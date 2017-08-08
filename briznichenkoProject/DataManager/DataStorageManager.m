//
//  DataStorageManager.m
//  briznichenkoProject
//
//  Created by briznichenko on 8/7/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "DataStorageManager.h"

@implementation DataStorageManager
{
    NSString *pathToModel;
}

@synthesize managedObjectModel, managedObjectContext, persistentStoreCoordinator;

#pragma mark -- Singleton Methods

+ (id)sharedManager
{
    static DataStorageManager *sharedDataManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDataManager = [[self alloc] init];
    });
    return sharedDataManager;
}

- (id) init
{
    if (self = [super init])
    {
        [self makeManager];
    }
    return self;
}

-(void) makeManager
{
    [self makeManagedObjectModel];
    [self makeEntites];
    [self makePersistentStoreCoordinator];
    [self makeManagedObjectContext];
}

#pragma mark -- Core Data Methods

- (void) makeManagedObjectModel
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *nameForModel = @"AppDataModel.momd";
    pathToModel = [documentsDirectory stringByAppendingFormat:@"/db/%@", nameForModel];
    
    managedObjectModel = nil;
    if([[NSFileManager defaultManager] fileExistsAtPath:pathToModel])
    {
        NSData *dataForModel = [NSData dataWithContentsOfFile:pathToModel];
        managedObjectModel = [NSKeyedUnarchiver unarchiveObjectWithData:dataForModel];
    }
    else
        managedObjectModel = [[NSManagedObjectModel alloc] init];
}

- (void) makePersistentStoreCoordinator
{
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: managedObjectModel];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDirectory = [paths objectAtIndex:0];
    
    NSString *nameForSQLiteStore = @"AppDataDb.sqlite";
    NSString *pathToSQLiteFolder = [cachesDirectory stringByAppendingString:@"/db/"];
    NSString *pathToSQLiteStore = [pathToSQLiteFolder stringByAppendingFormat:@"%@", nameForSQLiteStore];
    NSURL *SQLiteStoreURL = [NSURL fileURLWithPath: pathToSQLiteStore];
    
    NSError *error = nil;
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:pathToSQLiteFolder])
        [[NSFileManager defaultManager] createDirectoryAtPath:pathToSQLiteFolder withIntermediateDirectories:NO attributes:nil error:&error];
    
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:@"PF_DEFAULT_CONFIGURATION_NAME" URL:SQLiteStoreURL options:nil error:&error])
    {
        [[NSFileManager defaultManager] removeItemAtURL:SQLiteStoreURL error:NULL];
        if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:@"PF_DEFAULT_CONFIGURATION_NAME" URL:SQLiteStoreURL options:nil error:&error])
        {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (void) makeManagedObjectContext
{
    managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    
    [managedObjectContext setRetainsRegisteredObjects:YES];

    [managedObjectContext setMergePolicy:[[NSMergePolicy alloc] initWithMergeType:NSMergeByPropertyObjectTrumpMergePolicyType]];
    
    [managedObjectContext setPersistentStoreCoordinator:persistentStoreCoordinator];
}

#pragma mark -- Data Storage Entity Creation Methods

-(void) makeEntites
{
    [managedObjectModel setEntities:@[[self makeSpaceObjectEntityDescription]]];
    
    NSData *modelData = [NSKeyedArchiver archivedDataWithRootObject:managedObjectModel];
    [modelData writeToFile:pathToModel atomically:YES];
}

- (NSEntityDescription *) makeSpaceObjectEntityDescription
{
    NSEntityDescription *spaceObjectEntityDescription = [[NSEntityDescription alloc] init];
    [spaceObjectEntityDescription setName:@"SpaceObject"];
    
    NSAttributeDescription *nameAttribute = [[NSAttributeDescription alloc] init];
    [nameAttribute setName:@"Name"];
    [nameAttribute setAttributeType:NSStringAttributeType];
    [nameAttribute setOptional:NO];
    [nameAttribute setIndexed:YES];
    
    NSAttributeDescription *raDecAttribute = [[NSAttributeDescription alloc] init];
    [raDecAttribute setName:@"RaDec"];
    [raDecAttribute setAttributeType:NSStringAttributeType];
    [raDecAttribute setOptional:NO];
    [raDecAttribute setIndexed:YES];
    
    NSAttributeDescription *imageAttribute = [[NSAttributeDescription alloc] init];
    [imageAttribute setName:@"Image"];
    [imageAttribute setAttributeType:NSBinaryDataAttributeType];
    [imageAttribute setOptional:YES];
    [imageAttribute setIndexed:NO];
    
    NSAttributeDescription *infoAttribute = [[NSAttributeDescription alloc] init];
    [infoAttribute setName:@"info"];
    [infoAttribute setAttributeType:NSBinaryDataAttributeType];
    [infoAttribute setOptional:YES];
    [infoAttribute setIndexed:NO];
    
    [spaceObjectEntityDescription setProperties:@[nameAttribute, raDecAttribute, imageAttribute, infoAttribute]];
    
    return spaceObjectEntityDescription;
}

- (void)dealloc
{
    
}

@end
