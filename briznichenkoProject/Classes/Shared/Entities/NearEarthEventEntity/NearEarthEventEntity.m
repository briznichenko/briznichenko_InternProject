//
//  NearEarthEventEntity.m
//  briznichenkoProject
//
//  Created by briznichenko on 8/29/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "NearEarthEventEntity.h"

@implementation NearEarthEventEntity

- (instancetype) initFromDictionary:(NSDictionary *)eventDictionary
{
    self = [super init];
    if(self)
        [self setupWithDictionary: eventDictionary];
    return self;
}

- (void) setupWithDictionary:(NSDictionary *)eventDictionary
{
    self.event_image = [eventDictionary valueForKey:@"event_image"];
    self.event_image_description = [eventDictionary valueForKey:@"event_image_description"];
    self. event_title = [eventDictionary valueForKey:@"event_title"];
    self.event_type_icon = [eventDictionary valueForKey:@"event_type_icon"];
    self.event_type_description = [eventDictionary valueForKey:@"event_type_description"];
    self.event_date = [eventDictionary valueForKey:@"event_date"];
    self.event_description = [eventDictionary valueForKey:@"event_description"];
    self.source_url = [eventDictionary valueForKey:@"source_url"];
}

@end
