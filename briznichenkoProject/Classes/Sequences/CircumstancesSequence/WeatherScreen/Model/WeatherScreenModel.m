//
//  WeatherScreenModel.m
//  briznichenkoProject
//
//  Created by briznichenko on 21/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "WeatherScreenModel.h"


@implementation WeatherScreenModel


- (instancetype) initWithData
{
	self = [super init];
	if(self)
	{
	}
	return self;
}

-(void) getVisibleStars:(void (^)(bool finished))completionBlock
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURLSession *urlSession;
        NSURLSessionDataTask *dataTask;
        NSURL *url = [NSURL URLWithString:@"https://www.fourmilab.ch/cgi-bin/Yourtel?lat=77.6327&ns=North&lon=140.393&fov=45&z=1"];
        
        urlSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        dataTask = [urlSession
                    dataTaskWithURL:url
                    completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                        if(!error)
                        {
                            NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                            //@"<img src=\"\" usemap=";
                            completionBlock(1 > 0);
                        }
                        else
                            NSLog(@"Error:%@", error.localizedDescription);
                    }];
        [dataTask resume];
    });
}



@end
