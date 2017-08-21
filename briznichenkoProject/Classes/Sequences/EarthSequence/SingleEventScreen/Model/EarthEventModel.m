//
//  EarthEventModel.m
//  briznichenkoProject
//
//  Created by briznichenko on 8/18/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "EarthEventModel.h"
#import "ManagedEarthEventEntity.h"
#import "DataStorageManager.h"

@implementation EarthEventModel

- (instancetype) initWithData
{
    self = [super init];
    if(self)
    {
        
    }
    return self;
}

- (void) saveEvent: (void (^) (BOOL saved)) completionBlock
{
    NSManagedObjectContext *context = [[DataStorageManager sharedManager] managedObjectContext];
    ManagedEarthEventEntity *eventEntity = [NSEntityDescription insertNewObjectForEntityForName:@"EarthEvent" inManagedObjectContext:context];
    eventEntity.event_id = self.eventEntity.event_id;
    eventEntity.event_link = self.eventEntity.event_link;
    eventEntity.event_title = self.eventEntity.event_title;
    eventEntity.event_description = self.eventEntity.event_description;
    
    eventEntity.event_sources = [NSKeyedArchiver archivedDataWithRootObject:self.eventEntity.event_sources];
    eventEntity.event_categories = [NSKeyedArchiver archivedDataWithRootObject:self.eventEntity.event_categories];
    eventEntity.event_geometries = [NSKeyedArchiver archivedDataWithRootObject:self.eventEntity.event_geometries];
    
    NSError *error = nil;
    if ([context save:&error] == NO)
        NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
    else
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SavedSpaceObjectEntity" object:nil userInfo:nil];
}

@end
