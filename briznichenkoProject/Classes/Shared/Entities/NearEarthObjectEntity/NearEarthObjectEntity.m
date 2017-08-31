//
//  NearEarthObjectEntity.m
//  briznichenkoProject
//
//  Created by briznichenko on 8/23/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "NearEarthObjectEntity.h"

@implementation NearEarthObjectEntity

- (instancetype) initFromDictionary:(NSDictionary *)objectDictionary
{
    self = [super init];
    if(self)
        [self setupWithDictionary: objectDictionary];
    return self;
}

- (void) setupWithDictionary:(NSDictionary *)objectDictionary
{
    self.estimated_diameter = [objectDictionary valueForKey:@"estimated_diameter"];
    self.is_potentially_hazardous_asteroid = [self stringify: [objectDictionary valueForKey:@"is_potentially_hazardous_asteroid"]];
    self. neo_reference_id = [self stringify: [objectDictionary valueForKey:@"neo_reference_id"]];
    self.close_approach_data = [objectDictionary valueForKey:@"close_approach_data"];
    self.nasa_jpl_url = [self stringify: [objectDictionary valueForKey:@"nasa_jpl_url"]];
    self.orbital_data = [objectDictionary valueForKey:@"orbital_data"];
    self.links = [objectDictionary valueForKey:@"links"];
    self.name = [self stringify: [objectDictionary valueForKey:@"name"]];
    self.absolute_magnitude_h = [self stringify: [objectDictionary valueForKey:@"absolute_magnitude_h"]];
}

- (NSString *) stringify: (id) object
{
    return [NSString stringWithFormat:@"%@", object];
}

@end
