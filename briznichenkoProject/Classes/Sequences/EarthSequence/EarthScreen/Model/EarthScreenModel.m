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
        index = 0;
        epicImageURLs = [NSMutableArray new];
    }
    return self;
}

-(void) getImageURLsForDate:(NSDate*) date completion:(void (^)(bool finished))completionBlock
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

-(void)downloadImagePackForPreviousDay: (BOOL) direction completion:(void (^)(NSArray *imagesArray)) completion
{
    NSMutableArray *imagesArray = [NSMutableArray new];
    int count = index + amount;
    if(epicImageURLs.count == 0)
        [self getImageURLsForDate:[NSDate new] completion:^(bool finished){
            if(finished)
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    for(int i = index; i < count; i++)
                    {
                        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:epicImageURLs[i]]];
                        [imagesArray addObject:imageData];
                        if(imagesArray.count == amount)
                        {
                            index += amount;
                            completion(imagesArray);
                        }}});
        }];
    else
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            for(int i = index; i < count; i++)
            {
                NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:epicImageURLs[i]]];
                [imagesArray addObject:imageData];
                if(imagesArray.count == amount)
                {
                    index += amount;
                    completion(imagesArray);
                }}});
}

@end
