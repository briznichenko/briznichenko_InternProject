//
//  NearEarthEventEntity.h
//  briznichenkoProject
//
//  Created by briznichenko on 8/29/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NearEarthEventEntity : NSObject

@property (nonatomic, strong) NSData *event_image;
@property (nonatomic, strong) NSString *event_image_description;
@property (nonatomic, strong) NSString * event_title;
@property (nonatomic, strong) NSData *event_type_icon;
@property (nonatomic, strong) NSString *event_type_description;
@property (nonatomic, strong) NSString *event_date;
@property (nonatomic, strong) NSString *event_description;
@property (nonatomic, strong) NSString *source_url;

- (instancetype) initFromDictionary:(NSDictionary *)eventDictionary;

@end