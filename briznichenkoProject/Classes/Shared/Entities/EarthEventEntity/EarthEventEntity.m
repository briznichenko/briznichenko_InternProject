//
//  EarthEventEntity.m
//  briznichenkoProject
//
//  Created by briznichenko on 8/18/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "EarthEventEntity.h"

@implementation EarthEventEntity

@synthesize event_id, event_title, event_description, event_link, event_categories, event_sources, event_geometries;

- (instancetype) initFromDictionary:(NSDictionary *)eventDictionary
{
    self = [super init];
    if(self)
    {
        event_id = [eventDictionary valueForKey:@"id"];
        event_title = [eventDictionary valueForKey:@"title"];
        event_description = [eventDictionary valueForKey:@"description"];
        event_link = [eventDictionary valueForKey:@"link"];
        event_categories = [eventDictionary valueForKey:@"categories"];
        event_sources = [eventDictionary valueForKey:@"sources"];
        event_geometries = [eventDictionary valueForKey:@"geometries"];
    }
    return self;
}


@end
