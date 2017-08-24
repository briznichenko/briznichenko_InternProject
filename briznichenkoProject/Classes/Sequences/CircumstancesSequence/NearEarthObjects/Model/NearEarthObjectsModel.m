//
//  NearEarthObjectsModel.m
//  briznichenkoProject
//
//  Created by briznichenko on 23/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "NearEarthObjectsModel.h"

@implementation NearEarthObjectsModel
{
    NSString *nasaAPIKey;
}


- (instancetype) initWithData
{
	self = [super init];
	if(self)
	{
        nasaAPIKey = @"ZxAYPjTpa4xx4LPlkSQbV5oYkbVr27UJ26ys9EuB";
	}
	return self;
}

-(void)getNearbyObjectsFor:(NSDate *) startDate endDate:(NSDate *) endDate completion:(void (^)(NSDictionary *objects))completion
{
    NSURLSession *urlSession;
    NSURLSessionDataTask *dataTask;
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *startDateString = [formatter stringFromDate:startDate];
    NSString *endDateString = [formatter stringFromDate:endDate];
    
    NSString *stringURL = [NSString stringWithFormat:@"https://api.nasa.gov/neo/rest/v1/feed?start_date=%@&end_date=%@&api_key=%@",
                           startDateString,
                           endDateString,
                           nasaAPIKey];
    NSURL *url = [NSURL URLWithString:stringURL];
    NSLog(@"%@", stringURL);
    NSLog(@"%@", url.absoluteString);
    
    urlSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    dataTask = [urlSession
                dataTaskWithURL:url
                completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                    if(!error)
                    {
                        NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                        completion([jsonData valueForKey:@"near_earth_objects"]);
                    }
                    else if(error)
                    {
                        NSLog(@"Error getting nearby space objects: %@ \n", error.localizedDescription);
                    }
                }];
    [dataTask resume];
}

-(void)getSingleNearbyObjectByObjectID:(NSString *)objectID completion:(void (^)(bool finished))completion
{
    NSURLSession *urlSession;
    NSURLSessionDataTask *dataTask;
    
    NSString *stringURL = [NSString stringWithFormat:@"https://api.nasa.gov/neo/rest/v1/neo/%@?api_key=%@",
                           objectID,
                           nasaAPIKey];
    NSURL *url = [NSURL URLWithString:stringURL];
    NSLog(@"%@", stringURL);
    NSLog(@"%@", url.absoluteString);
    
    urlSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    dataTask = [urlSession
                dataTaskWithURL:url
                completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                    if(!error)
                    {
                        NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                        self.objectEntity = [[NearEarthObjectEntity alloc] initFromDictionary: jsonData];
                        completion(self.objectEntity != nil);
                    }
                    else if(error)
                    {
                        NSLog(@"Error getting nearby space objects: %@ \n", error.localizedDescription);
                    }
                }];
    [dataTask resume];
}


@end
