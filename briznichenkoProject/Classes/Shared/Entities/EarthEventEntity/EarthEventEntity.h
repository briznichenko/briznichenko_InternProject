//
//  EarthEventEntity.h
//  briznichenkoProject
//
//  Created by briznichenko on 8/18/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EarthEventEntity : NSObject

@property (nonatomic, strong) NSString *event_id;
@property (nonatomic, strong) NSString *event_title;
@property (nonatomic, strong) NSString *event_description;
@property (nonatomic, strong) NSString *event_link;
@property (nonatomic, strong) NSArray *event_categories;
@property (nonatomic, strong) NSArray *event_sources;
@property (nonatomic, strong) NSArray *event_geometries;

- (instancetype) initFromDictionary:(NSDictionary *)eventDictionary;

@end
