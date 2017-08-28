//
//  NearEarthObjectDetailModel.m
//  briznichenkoProject
//
//  Created by briznichenko on 23/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "NearEarthObjectDetailModel.h"


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

- (void) saveNearEarthObjectEntity: (void (^) (BOOL saved)) completion
{
//    NSManagedObjectContext *context = [[DataStorageManager sharedManager] managedObjectContext];
//    ManagedCelesctialBodyEntity *bodyEntity = [NSEntityDescription insertNewObjectForEntityForName:@"SpaceObject" inManagedObjectContext:context];
//    bodyEntity.name = self.bodyEntity.name;
//    bodyEntity.image = self.bodyEntity.image;
//    bodyEntity.raDec = self.bodyEntity.raDec;
//    bodyEntity.info = self.bodyEntity.info;
//
//    NSError *error = nil;
//    if ([context save:&error] == NO)
//        NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
//    else
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"SavedSpaceObjectEntity" object:nil userInfo:nil];
    NSLog(@"ToDo");
    completion(YES);
}


@end
