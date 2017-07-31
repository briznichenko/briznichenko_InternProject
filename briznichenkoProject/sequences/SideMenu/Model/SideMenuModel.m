//
//  SideMenuModel.m
//  briznichenkoProject
//
//  Created by briznichenko on 25/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "SideMenuModel.h"


@implementation SideMenuModel
{
    NSString *NASA_API_KEY;
}


- (instancetype) initWithParams
{
	self = [super init];
	if(self)
	{
        NASA_API_KEY = @"ZxAYPjTpa4xx4LPlkSQbV5oYkbVr27UJ26ys9EuB";
    }
	return self;
}

-(void) getImageData:(void (^)(NSData * fetchedData))completionBlock
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    NSURLSession *urlSession;
    NSURLSessionDataTask *dataTask;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.nasa.gov/EPIC/api/natural/images?api_key=%@", NASA_API_KEY]];
    
    urlSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    dataTask = [urlSession
                dataTaskWithURL:url
                completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                    if(!error)
                    {
                        NSArray *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                        NSString *dateString = [[jsonData[0] valueForKey:@"date"] stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
                        NSString *rawImageURL = [NSString stringWithFormat:@"https://epic.gsfc.nasa.gov/archive/natural/%@/jpg/%@.jpg" ,
                                                 [dateString stringByReplacingCharactersInRange:NSMakeRange(dateString.length - 9, 9) withString:@""],
                                                 [jsonData[0] valueForKey:@"image"]];
                        NSURL *imageURl = [NSURL URLWithString: rawImageURL];
                        NSData *imageData = [NSData dataWithContentsOfURL: imageURl];
                        completionBlock(imageData);
                    }
                    else
                        NSLog(@"Error:%@", error.localizedDescription);
                }];
    [dataTask resume];
    });
}


@end
