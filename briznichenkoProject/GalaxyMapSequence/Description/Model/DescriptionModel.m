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
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString:[self cutoutImageUrlConstructorString:self.bodyEntity.rawRaDecScaleString]];
        NSData *imageData = [NSData dataWithContentsOfURL: url];
        completion(imageData);
    });
}

-(NSString *)cutoutImageUrlConstructorString: (NSString *) rawRaDecScaleString
{
    NSArray *URLComponents = [rawRaDecScaleString componentsSeparatedByString: @"|"];
    NSString *rawURL = @"http://skyservice.pha.jhu.edu/DR7/ImgCutout/getjpeg.aspx?ra=%@&dec=%@&scale=%@&opt=&width=512&height=512";
    NSString *url = [NSString stringWithFormat: rawURL, URLComponents[0], URLComponents[1], URLComponents[2]];
    return url;
}

@end
