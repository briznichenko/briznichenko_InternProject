//
//  LibraryModel.m
//  briznichenkoProject
//
//  Created by briznichenko on 8/30/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "LibraryModel.h"
#import <CoreData/CoreData.h>
#import "DataStorageManager.h"

@implementation LibraryModel

-(void) fetchData:(void (^) (bool finished)) completionBlock
{
    NSArray *entityNames = @[@"SpaceObject", @"EarthEvent", @"NearEarthEvent", @"NearEarthObject"];
    
    NSManagedObjectContext *context = [[DataStorageManager sharedManager] managedObjectContext];
    NSMutableDictionary *fetchResutls = [NSMutableDictionary new];
    
    for(NSString *entityName in entityNames)
    {
        NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:entityName];
        NSError *error;
        NSArray *results = [context executeFetchRequest:request error:&error];
        if (error)
        {
            NSLog(@"Error fetching entities:%@", error.localizedDescription);
            completionBlock(NO);
        }
        else
            [fetchResutls setValue:results forKey:entityName];
        if(fetchResutls.allKeys.count == entityNames.count)
        {
            self.storedEntities = [NSDictionary dictionaryWithDictionary: fetchResutls];
            completionBlock(YES);
        }
    }
}

@end
