//
//  SpaceObjectsModel.m
//  briznichenkoProject
//
//  Created by briznichenko on 8/30/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "SpaceObjectsModel.h"
#import "CelestialBodyEntity.h"
#import "ManagedCelesctialBodyEntity.h"

@implementation SpaceObjectsModel

- (void) formatEntities
{
    NSMutableArray *remadeEntites = [NSMutableArray new];
    for (ManagedCelesctialBodyEntity *managedEntity in self.spaceObjects)
    {
        CelestialBodyEntity *bodyEntity = [CelestialBodyEntity new];
        bodyEntity.name = managedEntity.name;
        bodyEntity.image = managedEntity.image;
        bodyEntity.raDec = managedEntity.raDec;
        bodyEntity.info = managedEntity.info;
        [remadeEntites addObject:bodyEntity];
    }
    self.spaceObjects = remadeEntites;
}

@end
