//
//  NearEarthObjectEntity.h
//  briznichenkoProject
//
//  Created by briznichenko on 8/23/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NearEarthObjectEntity : NSObject


@property (nonatomic, strong) NSDictionary *estimated_diameter;
@property (nonatomic, strong) NSString *is_potentially_hazardous_asteroid;
@property (nonatomic, strong) NSString * neo_reference_id;
@property (nonatomic, strong) NSArray *close_approach_data;
@property (nonatomic, strong) NSString *nasa_jpl_url;
@property (nonatomic, strong) NSDictionary *orbital_data;
@property (nonatomic, strong) NSDictionary *links;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *absolute_magnitude_h;

- (instancetype) initFromDictionary:(NSDictionary *)objectDictionary;

@end
