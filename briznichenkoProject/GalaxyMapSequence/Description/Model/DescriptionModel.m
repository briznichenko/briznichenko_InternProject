//
//  DescriptionModel.m
//  briznichenkoProject
//
//  Created by briznichenko on 31/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "DescriptionModel.h"
#import "CelestialBodyEntity.h"
#import "DataStorageManager.h"
#import "ManagedCelesctialBodyEntity.h"

@implementation DescriptionModel

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

-(void)saveSpaceObjectEntity
{
    NSManagedObjectContext *context = [[DataStorageManager sharedManager] managedObjectContext];
    ManagedCelesctialBodyEntity *bodyEntity = [NSEntityDescription insertNewObjectForEntityForName:@"SpaceObject" inManagedObjectContext:context];
    bodyEntity.name = self.bodyEntity.name;
    bodyEntity.image = self.bodyEntity.image;
    bodyEntity.raDec = self.bodyEntity.raDec;
    bodyEntity.info = self.bodyEntity.info;
    
    NSError *error = nil;
    if ([context save:&error] == NO) {
        NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
    }
}

@end
