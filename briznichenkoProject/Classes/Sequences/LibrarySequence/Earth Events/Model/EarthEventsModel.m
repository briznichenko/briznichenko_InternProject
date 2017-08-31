//
//  EarthEventsModel.m
//  briznichenkoProject
//
//  Created by briznichenko on 8/30/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "ManagedEarthEventEntity.h"
#import "EarthEventEntity.h"
#import "EarthEventsModel.h"

@implementation EarthEventsModel

- (void) formatEntities
{
    NSMutableArray *remadeEntites = [NSMutableArray new];
    for (ManagedEarthEventEntity *managedEntity in self.earthEvents)
    {
        EarthEventEntity *eventEntity = [EarthEventEntity new];
        eventEntity.event_id = managedEntity.event_id;
        eventEntity.event_link = managedEntity.event_link;
        eventEntity.event_title = managedEntity.event_title;
        eventEntity.event_description = managedEntity.event_description;
        
        eventEntity.event_sources = [NSKeyedUnarchiver unarchiveObjectWithData:managedEntity.event_sources];
        eventEntity.event_categories = [NSKeyedUnarchiver unarchiveObjectWithData:managedEntity.event_categories];
        eventEntity.event_geometries = [NSKeyedUnarchiver unarchiveObjectWithData:managedEntity.event_geometries];
        
        [remadeEntites addObject:eventEntity];
    }
    self.earthEvents = remadeEntites;
}

@end
