//
//  CelestialBodyEntity.m
//  briznichenkoProject
//
//  Created by briznichenko on 7/27/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "CelestialBodyEntity.h"

@implementation CelestialBodyEntity

@dynamic name, image, raDec, info;

-(instancetype)initWithDictionary:(NSDictionary *)dataDictionary
{
    self = [super init];
    if(self)
    {
        self.name = [dataDictionary valueForKey:@"objName"];
        self.raDec = [dataDictionary valueForKey:@"coord1 (ICRS,J2000/2000)"];
        self.info = [NSString stringWithFormat:@"INFO: %@", dataDictionary];
    }
    return self;
}

@end
