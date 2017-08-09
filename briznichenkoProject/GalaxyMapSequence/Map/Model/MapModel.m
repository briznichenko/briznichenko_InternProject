//
//  MapModel.m
//  briznichenkoProject
//
//  Created by briznichenko on 18/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "MapModel.h"
#import "CelestialBodyEntity.h"


@implementation MapModel

- (instancetype) initModelWithData
{
	self = [super init];
	if(self)
	{
        [self fetchData];
	}
	return self;
}

-(void) fetchData
{
    self.data = [[self getAladinMapSource] dataUsingEncoding:NSUTF8StringEncoding];
}

-(NSString *)getAladinMapSource
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"AladinMap" ofType:@"html" inDirectory:@"AladinMap"];
    
    return [NSURL fileURLWithPath:path].absoluteString;
}

-(void) getCelestialDataByRa:(float)ra Dec:(float)dec FOV: (float) fov
{
    float urlFOV;
    if(fov >= 100)
        urlFOV = 6.0f;
    else if (fov < 100 && fov >= 10)
        urlFOV = 3.0f;
    else
        urlFOV = 1.5f;
    
    NSString *plainURL = [NSString stringWithFormat: @"http://simbad.u-strasbg.fr/simbad/sim-coo?output.format=ascii&Coord=%f+%f&Radius=%f&Radius.unit=arcmin", ra, dec, urlFOV];
    [self fetchEntityData:plainURL completion:^(NSDictionary *fetchedData)
    {
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"gotCelestialData"
         object:fetchedData];
        self.bodyEntity = [[CelestialBodyEntity alloc] initWithDictionary: fetchedData];
        [self extractAndDownloadImageFromEntity:self.bodyEntity completion:^(NSData *fetchedData) {
            self.bodyEntity.image = fetchedData;
        }];
    }];
}

#pragma mark Entity construction

-(void) fetchEntityData: (NSString *) stringUrl completion: (void (^)(NSDictionary * fetchedData))completionBlock
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURLSession *urlSession;
        NSURLSessionDataTask *dataTask;
        NSURL *url = [NSURL URLWithString: stringUrl];
        
        urlSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        dataTask = [urlSession
                    dataTaskWithURL:url
                    completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                        if(!error)
                        {
                            NSString *rawASCII = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                            completionBlock([self parseEntityFromString:rawASCII]);
                        }
                        else
                            NSLog(@"Error:%@", error.localizedDescription);
                    }];
        [dataTask resume];
    });
}

-(NSDictionary *) parseEntityFromString:(NSString *) rawASCII
{
    NSArray *rawData = [rawASCII componentsSeparatedByString: @"\n"];
    
    NSString *errorString = @"!! No astronomical object found : ";
    NSString *startString = @"Number of";
    NSString *objectStartString = @"Object";
    NSString *endString = @"================================================================================";
    NSMutableArray *parsedData = [NSMutableArray new];
    
    if([rawData[0] isEqualToString:errorString])
        return @{@"objName" : @"There is nothing here but void"};
    else if ([[rawData[5] substringToIndex:6] isEqualToString: objectStartString])
    {
        int endIndex = (int)[rawData indexOfObject: endString];
        for(int i = 5; i < endIndex; i++)
        {
            [parsedData addObject:[rawData[i] componentsSeparatedByString:@"|"]];
        }
        return [self objectDictionaryFromArray:parsedData];
    }
    else if([[rawData[5] substringToIndex:9] isEqualToString: startString])
    {
        int endIndex = (int)[rawData indexOfObject: endString];
        for(int i = 9; i < endIndex; i++)
        {
            [parsedData addObject:[rawData[i] componentsSeparatedByString:@"|"]];
        }
        return [self objectDictionaryFromArray: [self findMostFamousObject:parsedData]];
    }
    
    return @{@"objName" : @"UNDEFINED"};
}

-(NSArray*) findMostFamousObject: (NSArray *) arrayOfObjects
{
    int max = 0;
    int maxIndex = 0;
    
    for(NSArray * objectArray in arrayOfObjects)
    {
        NSString *bibString = objectArray[11];
        int bib = bibString.intValue;
        max = bib > max ? bib : max;
        maxIndex = bib > max ? (int)[arrayOfObjects indexOfObject:objectArray] : maxIndex;
    }
    
    return arrayOfObjects[maxIndex];
}

-(NSDictionary*) objectDictionaryFromArray:(NSArray*) objectArray
{
    NSDictionary *objectDictionary;
    if(objectArray.count == 13)
    {
        NSArray *keys = @[@"#", @"dist(asec)",@"objName",@"typ",@"coord1 (ICRS,J2000/2000)",@"Mag U",@"Mag B",@"Mag V",@"Mag R",@"Mag I",@"spec. type",@"#bib",@"#not"];
        objectDictionary = [[NSDictionary alloc] initWithObjects:objectArray forKeys:keys];
    }
    else if(objectArray.count > 13)
    {
        NSMutableArray *values = [NSMutableArray new];
        NSMutableArray *keys = [NSMutableArray new];
        
        NSString *objName = objectArray[0][0];
        [values addObject: [objName substringWithRange:NSMakeRange(7, [objName rangeOfString:@"---"].location - 7)]];
        [keys addObject:@"objName"];
        for(NSArray *objEntry in objectArray)
        {
            NSString *objString = objEntry[0];
            NSArray *keyValueArray;
            if ([objString containsString:@":"])
            {
                keyValueArray = [objString componentsSeparatedByString:@":"];
                [values addObject:keyValueArray[1]];
                [keys addObject:keyValueArray[0]];
            }
            objectDictionary = [[NSDictionary alloc] initWithObjects:values forKeys:keys];
        }
    }
    return objectDictionary;
}

#pragma mark -- Object Imagery

-(void) extractAndDownloadImageFromEntity: (CelestialBodyEntity *) entity completion: (void (^) (NSData *fetchedData)) completion
{
    NSString *rawRaDecString = [[NSKeyedUnarchiver unarchiveObjectWithData:entity.info] valueForKey:@"coord1 (ICRS,J2000/2000)"];
    rawRaDecString = [rawRaDecString stringByReplacingCharactersInRange:NSMakeRange(12, 1) withString:@"|"];
    NSURL *url = [NSURL URLWithString:[self cutoutImageUrlConstructorString:rawRaDecString]];
    NSLog(@"%@", url);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL: url];
        completion(imageData);
    });
}

-(NSString *)cutoutImageUrlConstructorString: (NSString *) rawRaDecScaleString
{
    NSArray *URLComponents = [rawRaDecScaleString componentsSeparatedByString: @"|"];
    NSString *rawURL = @"http://archive.eso.org/dss/dss/image?ra=%@&dec=%@&equinox=J2000&name=&x=%i&y=%i&Sky-Survey=DSS1&mime-type=download-gif";
    NSString *url = [NSString stringWithFormat: rawURL, URLComponents[0], URLComponents[1], 8, 6];
    
    NSString* webURL = [url stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    
    return webURL;
}

- (void) imageryForObjectWithName: (NSString *)objectName completion: (void (^)(NSArray *imageryArray)) completion
{
    NSURLSession *urlSession;
    NSURLSessionDataTask *dataTask;
    NSString *urlQueryName = [self constructQueryNameFromOriginalName:objectName];
    NSURL *url = [[NSURL URLWithString:[NSString stringWithFormat:@"https://images-api.nasa.gov/search?q=%@", urlQueryName]] URLByResolvingSymlinksInPath];
    NSLog(@"%@", url.absoluteString);
    
    urlSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    dataTask = [urlSession
                dataTaskWithURL:url
                completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                    if(data)
                    {
                        NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                        NSArray *collections = [[jsonData valueForKey:@"collection"] valueForKey:@"items"];
                        if(!collections)
                            completion(nil);
                        NSMutableArray *collectionURLs = [NSMutableArray new];
                        for (NSDictionary *collection in collections)
                            [collectionURLs addObject:[collection valueForKey:@"href"]];
                        [self getImageryFromCollectionWithURLs:collectionURLs completion:^(NSArray *imageryArray) {
                            completion(imageryArray);
                        }];
                    }
                    else if(error)
                        NSLog(@"Error getting imagery urls%@", error.localizedDescription);
                    else if(!data)
                        completion(nil);
                }];
    [dataTask resume];
}

-(void) getImageryFromCollectionWithURLs: (NSArray *) collectionURLs completion: (void (^)(NSArray *imageryArray)) completion
{
    NSMutableSet *imageURLs = [NSMutableSet new];
    NSMutableSet *imageryDataArray = [NSMutableSet new];
    
    for(NSString *url in collectionURLs)
    {
        NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        NSArray *assetURLs = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
        [imageURLs addObjectsFromArray: assetURLs];
    }
    __block unsigned long counter = imageURLs.count;
    for (NSString *imageURL in imageURLs)
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [imageryDataArray addObject:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]]];
            NSLog(@"Images left: %lu", --counter);
            if(counter == 0)
                completion(imageryDataArray.allObjects);
        });
}

-(NSString *) constructQueryNameFromOriginalName: (NSString *) objectName
{
    NSArray *nameComponents = [objectName componentsSeparatedByString:@" "];
    if([nameComponents[0] length] > 1)
        return nameComponents[0];
    else if (nameComponents.count > 0 && [nameComponents[1] length] > 1)
        return [nameComponents[0] stringByAppendingString:nameComponents[1]];
    else if (nameComponents.count > 1)
        return [NSString stringWithFormat:@"%@%@%@", nameComponents[0], nameComponents[1], nameComponents[2]];
    return @"M100";
}

@end
