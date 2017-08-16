//
//  EarthScreenModel.m
//  briznichenkoProject
//
//  Created by briznichenko on 8/16/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "EarthScreenModel.h"

@implementation EarthScreenModel
{
    NSMutableArray *epicImageURLs;
    int index;
}
static int amount = 3;

- (instancetype) initWithData
{
    self = [super init];
    if(self)
    {
        epicImageURLs = [NSMutableArray new];
    }
    return self;
}

-(void) getEPICData:(void (^)(bool finished))completionBlock
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURLSession *urlSession;
        NSURLSessionDataTask *dataTask;
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.nasa.gov/EPIC/api/natural/images?api_key=%@", @"ZxAYPjTpa4xx4LPlkSQbV5oYkbVr27UJ26ys9EuB"]];
        
        urlSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        dataTask = [urlSession
                    dataTaskWithURL:url
                    completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                        if(!error)
                        {
                            NSArray *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                            for(NSDictionary *jsonDict in jsonData)
                            {
                                NSString *dateString = [[jsonDict valueForKey:@"date"] stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
                                NSString *rawImageURL = [NSString stringWithFormat:@"https://epic.gsfc.nasa.gov/archive/natural/%@/jpg/%@.jpg" ,
                                                         [dateString stringByReplacingCharactersInRange:NSMakeRange(dateString.length - 9, 9) withString:@""],
                                                         [jsonDict valueForKey:@"image"]];
                                [epicImageURLs addObject:rawImageURL];
                            }
                            completionBlock(epicImageURLs.count == jsonData.count);
                        }
                        else
                            NSLog(@"Error:%@", error.localizedDescription);
                    }];
        [dataTask resume];
    });
}

-(void)downloadNextImages:(void (^)(NSArray *imagesArray)) completion
{
    NSMutableArray *imagesArray = [NSMutableArray new];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for(int i = 0; i < 3; i++)
        {
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:epicImageURLs[i]]];
            [imagesArray addObject:imageData];
            if(imagesArray.count == amount)
                completion(imagesArray);
        }
    });
}

@end
