//
//  NearEarthEventsModel.m
//  briznichenkoProject
//
//  Created by briznichenko on 8/30/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "SavedNearEarthEventsModel.h"
#import "ManagedNearEarthEventEntity.h"
#import "NearEarthEventEntity.h"

@implementation SavedNearEarthEventsModel

- (void) formatEntities
{
    NSMutableArray *remadeEntites = [NSMutableArray new];
    for (ManagedNearEarthEventEntity *managedEntity in self.nearEarthEvents)
    {
        NearEarthEventEntity *eventEntity = [NearEarthEventEntity new];
        
        eventEntity.event_image = managedEntity.event_image;
        eventEntity.event_image_description = managedEntity.event_image_description;
        eventEntity.event_title = managedEntity.event_title;
        eventEntity.event_date = managedEntity.event_date;
        eventEntity.event_type_icon = managedEntity.event_type_icon;
        eventEntity.event_type_description = managedEntity.event_type_description;
        eventEntity.event_description = managedEntity.event_description;
        eventEntity.source_url = managedEntity.source_url;
        
        [remadeEntites addObject:eventEntity];
    }
    self.nearEarthEvents = remadeEntites;
}

@end
