//
//  ManagedEarthEventEntity.h
//  briznichenkoProject
//
//  Created by briznichenko on 8/21/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface ManagedEarthEventEntity : NSManagedObject

@property (nonatomic, strong) NSString *event_id;
@property (nonatomic, strong) NSString *event_title;
@property (nonatomic, strong) NSString *event_description;
@property (nonatomic, strong) NSString *event_link;
@property (nonatomic, strong) NSData *event_categories;
@property (nonatomic, strong) NSData *event_sources;
@property (nonatomic, strong) NSData *event_geometries;

@end
