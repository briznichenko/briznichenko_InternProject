//
//  ManagedNearEarthObjectEntity.h
//  briznichenkoProject
//
//  Created by briznichenko on 8/29/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface ManagedNearEarthObjectEntity : NSManagedObject

@property (nonatomic, strong) NSData *estimated_diameter;
@property (nonatomic, strong) NSString *is_potentially_hazardous_asteroid;
@property (nonatomic, strong) NSString * neo_reference_id;
@property (nonatomic, strong) NSData *close_approach_data;
@property (nonatomic, strong) NSString *nasa_jpl_url;
@property (nonatomic, strong) NSData *orbital_data;
@property (nonatomic, strong) NSData *links;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *absolute_magnitude_h;

@end
