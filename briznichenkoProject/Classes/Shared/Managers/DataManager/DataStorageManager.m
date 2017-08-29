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
    [managedObjectModel setEntities:@[[self makeSpaceObjectEntityDescription] ,[self makeEarthEventEntityDescription]]];
    
    NSData *modelData = [NSKeyedArchiver archivedDataWithRootObject:managedObjectModel];
    [modelData writeToFile:pathToModel atomically:YES];
}

#pragma mark -- Entity Description Creation

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
    
    [spaceObjectEntityDescription setProperties:@[nameAttribute,
                                                  raDecAttribute,
                                                  imageAttribute,
                                                  infoAttribute]];
    
    return spaceObjectEntityDescription;
}

- (NSEntityDescription *) makeEarthEventEntityDescription
{
    NSEntityDescription *spaceObjectEntityDescription = [[NSEntityDescription alloc] init];
    [spaceObjectEntityDescription setName:@"EarthEvent"];
    
    NSAttributeDescription *idAttribute = [[NSAttributeDescription alloc] init];
    [idAttribute setName:@"event_id"];
    [idAttribute setAttributeType:NSStringAttributeType];
    [idAttribute setOptional:NO];
    [idAttribute setIndexed:YES];
    
    NSAttributeDescription *titleAttribute = [[NSAttributeDescription alloc] init];
    [titleAttribute setName:@"event_title"];
    [titleAttribute setAttributeType:NSStringAttributeType];
    [titleAttribute setOptional:NO];
    [titleAttribute setIndexed:YES];
    
    NSAttributeDescription *descriptionAttribute = [[NSAttributeDescription alloc] init];
    [descriptionAttribute setName:@"event_description"];
    [descriptionAttribute setAttributeType:NSStringAttributeType];
    [descriptionAttribute setOptional:NO];
    [descriptionAttribute setIndexed:YES];
    
    NSAttributeDescription *linkAttribute = [[NSAttributeDescription alloc] init];
    [linkAttribute setName:@"event_link"];
    [linkAttribute setAttributeType:NSStringAttributeType];
    [linkAttribute setOptional:NO];
    [linkAttribute setIndexed:YES];
    
    NSAttributeDescription *categoriesAttribute = [[NSAttributeDescription alloc] init];
    [categoriesAttribute setName:@"event_categories"];
    [categoriesAttribute setAttributeType:NSBinaryDataAttributeType];
    [categoriesAttribute setOptional:YES];
    [categoriesAttribute setIndexed:NO];
    
    NSAttributeDescription *sourcesAttribute = [[NSAttributeDescription alloc] init];
    [sourcesAttribute setName:@"event_sources"];
    [sourcesAttribute setAttributeType:NSBinaryDataAttributeType];
    [sourcesAttribute setOptional:YES];
    [sourcesAttribute setIndexed:NO];
    
    NSAttributeDescription *geometriesAttribute = [[NSAttributeDescription alloc] init];
    [geometriesAttribute setName:@"event_geometries"];
    [geometriesAttribute setAttributeType:NSBinaryDataAttributeType];
    [geometriesAttribute setOptional:YES];
    [geometriesAttribute setIndexed:NO];
    
    [spaceObjectEntityDescription setProperties:@[idAttribute,
                                                  titleAttribute,
                                                  descriptionAttribute,
                                                  linkAttribute,
                                                  categoriesAttribute,
                                                  sourcesAttribute,
                                                  geometriesAttribute]];
    
    return spaceObjectEntityDescription;
}

- (NSEntityDescription *) makeNearEarthEventEntityDescription
{
    NSEntityDescription *nearEarthEventEntityDescription = [[NSEntityDescription alloc] init];
    [nearEarthEventEntityDescription setName:@"NearEarthEvent"];
  
    NSAttributeDescription *imageAttribute = [[NSAttributeDescription alloc] init];
    [imageAttribute setName:@"event_id"];
    [imageAttribute setAttributeType:NSBinaryDataAttributeType];
    [imageAttribute setOptional:NO];
    [imageAttribute setIndexed:YES];
    
    NSAttributeDescription *imageDescriptionAttribute = [[NSAttributeDescription alloc] init];
    [imageDescriptionAttribute setName:@"event_image_description"];
    [imageDescriptionAttribute setAttributeType:NSStringAttributeType];
    [imageDescriptionAttribute setOptional:NO];
    [imageDescriptionAttribute setIndexed:YES];
    
    NSAttributeDescription *titleAttribute = [[NSAttributeDescription alloc] init];
    [titleAttribute setName:@"event_title"];
    [titleAttribute setAttributeType:NSStringAttributeType];
    [titleAttribute setOptional:NO];
    [titleAttribute setIndexed:YES];
    
    NSAttributeDescription *typeIconAttribute = [[NSAttributeDescription alloc] init];
    [typeIconAttribute setName:@"event_type_icon"];
    [typeIconAttribute setAttributeType:NSBinaryDataAttributeType];
    [typeIconAttribute setOptional:NO];
    [typeIconAttribute setIndexed:YES];
    
    NSAttributeDescription *typeDescriptionAttribute = [[NSAttributeDescription alloc] init];
    [typeDescriptionAttribute setName:@"event_type_description"];
    [typeDescriptionAttribute setAttributeType:NSStringAttributeType];
    [typeDescriptionAttribute setOptional:NO];
    [typeDescriptionAttribute setIndexed:YES];
    
    NSAttributeDescription *dateAttribute = [[NSAttributeDescription alloc] init];
    [dateAttribute setName:@"event_date"];
    [dateAttribute setAttributeType:NSStringAttributeType];
    [dateAttribute setOptional:NO];
    [dateAttribute setIndexed:YES];
    
    NSAttributeDescription *descriptionAttribute = [[NSAttributeDescription alloc] init];
    [descriptionAttribute setName:@"event_description"];
    [descriptionAttribute setAttributeType:NSStringAttributeType];
    [descriptionAttribute setOptional:NO];
    [descriptionAttribute setIndexed:YES];
    
    NSAttributeDescription *sourceURLAttribute = [[NSAttributeDescription alloc] init];
    [sourceURLAttribute setName:@"source_url"];
    [sourceURLAttribute setAttributeType:NSStringAttributeType];
    [sourceURLAttribute setOptional:NO];
    [sourceURLAttribute setIndexed:YES];
    
    [nearEarthEventEntityDescription setProperties:@[imageAttribute,
                                                      imageDescriptionAttribute,
                                                      titleAttribute,
                                                      typeIconAttribute,
                                                      typeDescriptionAttribute,
                                                      dateAttribute,
                                                      descriptionAttribute,
                                                      sourceURLAttribute]];
    return nearEarthEventEntityDescription;
}

- (NSEntityDescription *) makeNearEarthObjectEntityDescription
{
    NSEntityDescription *nearEarthObjectEntityDescription = [[NSEntityDescription alloc] init];
    [nearEarthObjectEntityDescription setName:@"NearEarthObject"];
    
    NSAttributeDescription *diameterAttribute = [[NSAttributeDescription alloc] init];
    [diameterAttribute setName:@"estimated_diameter"];
    [diameterAttribute setAttributeType:NSBinaryDataAttributeType];
    [diameterAttribute setOptional:NO];
    [diameterAttribute setIndexed:YES];
    
    NSAttributeDescription *hazardousAttribute = [[NSAttributeDescription alloc] init];
    [hazardousAttribute setName:@"is_potentially_hazardous_asteroid"];
    [hazardousAttribute setAttributeType:NSStringAttributeType];
    [hazardousAttribute setOptional:NO];
    [hazardousAttribute setIndexed:YES];
    
    NSAttributeDescription *neoIDAttribute = [[NSAttributeDescription alloc] init];
    [neoIDAttribute setName:@"neo_reference_id"];
    [neoIDAttribute setAttributeType:NSStringAttributeType];
    [neoIDAttribute setOptional:NO];
    [neoIDAttribute setIndexed:YES];
    
    NSAttributeDescription *approachDataAttribute = [[NSAttributeDescription alloc] init];
    [approachDataAttribute setName:@"close_approach_data"];
    [approachDataAttribute setAttributeType:NSBinaryDataAttributeType];
    [approachDataAttribute setOptional:NO];
    [approachDataAttribute setIndexed:YES];
    
    NSAttributeDescription *nasaURLAttribute = [[NSAttributeDescription alloc] init];
    [nasaURLAttribute setName:@"nasa_jpl_url"];
    [nasaURLAttribute setAttributeType:NSStringAttributeType];
    [nasaURLAttribute setOptional:YES];
    [nasaURLAttribute setIndexed:NO];
    
    NSAttributeDescription *orbitalDataAttribute = [[NSAttributeDescription alloc] init];
    [orbitalDataAttribute setName:@"orbital_data"];
    [orbitalDataAttribute setAttributeType:NSBinaryDataAttributeType];
    [orbitalDataAttribute setOptional:YES];
    [orbitalDataAttribute setIndexed:NO];
    
    NSAttributeDescription *linksAttribute = [[NSAttributeDescription alloc] init];
    [linksAttribute setName:@"links"];
    [linksAttribute setAttributeType:NSBinaryDataAttributeType];
    [linksAttribute setOptional:YES];
    [linksAttribute setIndexed:NO];
    
    NSAttributeDescription *nameAttribute = [[NSAttributeDescription alloc] init];
    [nameAttribute setName:@"name"];
    [nameAttribute setAttributeType:NSStringAttributeType];
    [nameAttribute setOptional:YES];
    [nameAttribute setIndexed:NO];
    
    NSAttributeDescription *magnitudeAttribute = [[NSAttributeDescription alloc] init];
    [magnitudeAttribute setName:@"absolute_magnitude_h"];
    [magnitudeAttribute setAttributeType:NSStringAttributeType];
    [magnitudeAttribute setOptional:YES];
    [magnitudeAttribute setIndexed:NO];
    
    [nearEarthObjectEntityDescription setProperties:@[diameterAttribute,
                                                      hazardousAttribute,
                                                      hazardousAttribute,
                                                      neoIDAttribute,
                                                      approachDataAttribute,
                                                      nasaURLAttribute,
                                                      orbitalDataAttribute,
                                                      linksAttribute,
                                                      nameAttribute,
                                                      magnitudeAttribute]];
    return nearEarthObjectEntityDescription;
}

@end
