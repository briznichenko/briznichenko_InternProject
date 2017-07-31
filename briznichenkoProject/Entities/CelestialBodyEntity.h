//
//  CelestialBodyEntity.h
//  briznichenkoProject
//
//  Created by briznichenko on 7/27/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CelestialBodyEntity : NSObject

@property (nonatomic, strong) NSString * bodyName;
@property (nonatomic, strong) NSString * bodyRaDec;

- (instancetype) initWithDictionary: (NSDictionary *) dataDictionary;

@end
