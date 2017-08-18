//
//  EventsTableModel.m
//  briznichenkoProject
//
//  Created by briznichenko on 8/18/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "EventsTableModel.h"

@implementation EventsTableModel

- (instancetype) initWithData
{
    self = [super init];
    if(self)
    {
        self.events = [NSArray new];
    }
    return self;
}

-(void) getEventsForCategoryID: (int) category_id completion:(void (^)(bool finished))completionBlock
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURLSession *urlSession;
        NSURLSessionDataTask *dataTask;
        NSURL *url = [NSURL URLWithString:[@"https://eonet.sci.gsfc.nasa.gov/api/v2.1/categories/" stringByAppendingString:[NSString stringWithFormat:@"%d", category_id]]];
        
        urlSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        dataTask = [urlSession
                    dataTaskWithURL:url
                    completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                        if(!error)
                        {
                            NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                            NSLog(@"%@", jsonData);
                            NSArray *rawEvents = [jsonData valueForKey:@"events"];
                            NSMutableArray *events = [NSMutableArray new];
                            for(NSDictionary *event in rawEvents)
                            {
                                [events addObject: event];
                            }
                            self.events = [NSArray arrayWithArray:events];
                            completionBlock(self.events.count > 0);
                        }
                        else
                            NSLog(@"Error:%@", error.localizedDescription);
                    }];
        [dataTask resume];
    });
}

-(void)getEntityForIndex:(int)event_index
{
    self.entity = [[EarthEventEntity alloc] initFromDictionary:self.events[event_index]];
}

@end
