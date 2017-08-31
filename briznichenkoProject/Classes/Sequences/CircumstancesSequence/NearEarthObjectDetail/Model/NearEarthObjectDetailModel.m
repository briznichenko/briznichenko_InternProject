//
//  NearEarthObjectDetailModel.m
//  briznichenkoProject
//
//  Created by briznichenko on 23/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "NearEarthObjectDetailModel.h"
#import <CoreData/CoreData.h>
#import "DataStorageManager.h"
#import "ManagedNearEarthObjectEntity.h"

@implementation NearEarthObjectDetailModel


- (instancetype) initWithData
{
	self = [super init];
	if(self)
	{
        [self fetchData];
	}
	return self;
}

-(void) fetchData
{
    self.data = [NSData new];
}

#pragma mark -- Core Data methods

- (void) saveNearEarthObject: (void (^) (BOOL saved)) completionBlock
{
    NSManagedObjectContext *context = [[DataStorageManager sharedManager] managedObjectContext];
    ManagedNearEarthObjectEntity *objectEntity = [NSEntityDescription insertNewObjectForEntityForName:@"NearEarthObject" inManagedObjectContext:context];
    
    objectEntity.estimated_diameter = [NSKeyedArchiver archivedDataWithRootObject:self.objectEntity.estimated_diameter];
    objectEntity.is_potentially_hazardous_asteroid = self.objectEntity.is_potentially_hazardous_asteroid;
    objectEntity. neo_reference_id = self.objectEntity. neo_reference_id;
    objectEntity.close_approach_data = [NSKeyedArchiver archivedDataWithRootObject:self.objectEntity.close_approach_data];
    objectEntity.nasa_jpl_url = self.objectEntity.nasa_jpl_url;
    objectEntity.orbital_data = [NSKeyedArchiver archivedDataWithRootObject:self.objectEntity.orbital_data];
    objectEntity.links = [NSKeyedArchiver archivedDataWithRootObject:self.objectEntity.links];
    objectEntity.name = self.objectEntity.name;
    objectEntity.absolute_magnitude_h = self.objectEntity.absolute_magnitude_h;
    
    NSError *error = nil;
    if ([context save:&error] == NO)
    {
        NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
        completionBlock(NO);
    }
    else
        completionBlock(YES);
}


@end
