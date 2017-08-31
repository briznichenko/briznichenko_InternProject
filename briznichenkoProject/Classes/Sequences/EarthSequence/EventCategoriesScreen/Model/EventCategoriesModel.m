//
//  EventCategoriesModel.m
//  briznichenkoProject
//
//  Created by briznichenko on 8/18/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "EventCategoriesModel.h"

@implementation EventCategoriesModel

- (instancetype) initWithData
{
    self = [super init];
    if(self)
    {
        self.eventCategories = [NSArray new];
    }
    return self;
}

-(void) getEventCategories:(void (^)(bool finished))completionBlock
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURLSession *urlSession;
        NSURLSessionDataTask *dataTask;
        NSURL *url = [NSURL URLWithString:@"https://eonet.sci.gsfc.nasa.gov/api/v2.1/categories"];
        
        urlSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        dataTask = [urlSession
                    dataTaskWithURL:url
                    completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                        if(!error)
                        {
                            NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                            NSArray *rawCategories = [jsonData valueForKey:@"categories"];
                            NSMutableArray *categories = [NSMutableArray new];
                            for(NSDictionary *category in rawCategories)
                                [categories addObject: category];
                            self.eventCategories = [NSArray arrayWithArray:categories];
                            completionBlock(self.eventCategories.count > 0);
                        }
                        else
                            NSLog(@"Error:%@", error.localizedDescription);
                    }];
        [dataTask resume];
    });
}

@end
