//
//  SavedNearEarthObjectsModel.m
//  briznichenkoProject
//
//  Created by briznichenko on 8/30/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "SavedNearEarthObjectsModel.h"
#import "NearEarthObjectEntity.h"
#import "ManagedNearEarthObjectEntity.h"

@implementation SavedNearEarthObjectsModel

- (void) formatEntities
{
    NSMutableArray *remadeEntites = [NSMutableArray new];
    for (ManagedNearEarthObjectEntity *managedEntity in self.nearEarthObjects)
    {
        NearEarthObjectEntity *objectEntity = [NearEarthObjectEntity new];
        objectEntity.estimated_diameter = [NSKeyedUnarchiver unarchiveObjectWithData:managedEntity.estimated_diameter];
        objectEntity.is_potentially_hazardous_asteroid = managedEntity.is_potentially_hazardous_asteroid;
        objectEntity. neo_reference_id = managedEntity. neo_reference_id;
        objectEntity.close_approach_data = [NSKeyedUnarchiver unarchiveObjectWithData:managedEntity.close_approach_data];
        objectEntity.nasa_jpl_url = managedEntity.nasa_jpl_url;
        objectEntity.orbital_data = [NSKeyedUnarchiver unarchiveObjectWithData:managedEntity.orbital_data];
        objectEntity.links = [NSKeyedUnarchiver unarchiveObjectWithData:managedEntity.links];
        objectEntity.name = managedEntity.name;
        objectEntity.absolute_magnitude_h = managedEntity.absolute_magnitude_h;
        [remadeEntites addObject:objectEntity];
    }
    self.nearEarthObjects = remadeEntites;
}

@end
