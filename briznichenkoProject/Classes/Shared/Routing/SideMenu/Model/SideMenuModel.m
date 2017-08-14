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
    NSString *APOD_url;
}


- (instancetype) initWithParams
{
	self = [super init];
	if(self)
	{
        NASA_API_KEY = @"ZxAYPjTpa4xx4LPlkSQbV5oYkbVr27UJ26ys9EuB";
        APOD_url = @"https://api.nasa.gov/planetary/apod?api_key=%@";
    }
	return self;
}

-(void) getImageData:(void (^)(NSData * fetchedData))completionBlock
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURLSession *urlSession;
        NSURLSessionDataTask *dataTask;
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:APOD_url, NASA_API_KEY]];

        urlSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        dataTask = [urlSession
                    dataTaskWithURL:url
                    completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                        if(!error)
                        {
                            NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                            if([[jsonData valueForKey:@"media_type"] isEqualToString:@"video"])
                            {
                                NSString *video_url = [jsonData valueForKey:@"url"];
                                NSRange rangeStart = [video_url rangeOfString:@"embed/"];
                                NSRange rangeEnd = [video_url rangeOfString:@"?rel=0"];
                                
                                NSString *video_id = [video_url substringWithRange:NSMakeRange(rangeStart.location + rangeStart.length,
                                                                                               rangeEnd.location - rangeEnd.length - rangeStart.location)];
                                NSString *image_url = [NSString stringWithFormat:@"https://img.youtube.com/vi/%@/0.jpg", video_id];
                                NSURL *imageURl = [NSURL URLWithString: image_url];
                                NSData *imageData = [NSData dataWithContentsOfURL: imageURl];
                                completionBlock(imageData);
                            }
                            else
                            {
                                NSURL *imageURl = [NSURL URLWithString: [jsonData valueForKey:@"url"]];
                                NSData *imageData = [NSData dataWithContentsOfURL: imageURl];
                                completionBlock(imageData);
                            }
                        }
                        else
                        {
                            NSLog(@"Error downloading side menu image:%@", error.localizedDescription);
                        }
                    }];
        [dataTask resume];
    });
}

@end
