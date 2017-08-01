//
//  DescriptionModel.m
//  briznichenkoProject
//
//  Created by briznichenko on 31/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "DescriptionModel.h"
#import "CelestialBodyEntity.h"


@implementation DescriptionModel

- (instancetype) initWithData
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
    self.data = [NSData new];
}

-(void) extractAndDownloadImageFromEntity : (void (^) (NSData *fetchedData)) completion
{
    NSString *rawRaDecString = [self.bodyEntity.internalData valueForKey:@"coord1 (ICRS,J2000/2000)"];
    //    NSRange *raRange = NSMakeRange([rawRaDecString rangeOfString:@"."], NSUInteger len);
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
    NSString *url = [NSString stringWithFormat: rawURL, URLComponents[0], URLComponents[1], 5, 5];
    
    NSString* webURL = [url stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    
    return webURL;
}

@end
