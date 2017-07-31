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
    NSString *plainURL = [NSString stringWithFormat: @"http://simbad.u-strasbg.fr/simbad/sim-coo?output.format=ascii&Coord=%f+%f&Radius=%f&Radius.unit=arcmin", ra, dec, 1.5];
    [self fetchEntityData:plainURL completion:^(NSDictionary *fetchedData)
    {
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"gotCelestialData"
         object:fetchedData];
    }];
}

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
        NSArray *keys = @[@"#", @"dist(asec)",@"identifier",@"typ",@"coord1 (ICRS,J2000/2000)",@"Mag U",@"Mag B",@"Mag V",@"Mag R",@"Mag I",@"spec. type",@"#bib",@"#not"];
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

@end
