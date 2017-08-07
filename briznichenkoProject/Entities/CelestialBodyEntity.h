//
//  CelestialBodyEntity.h
//  briznichenkoProject
//
//  Created by briznichenko on 7/27/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CelestialBodyEntity : NSManagedObject

@property (nonatomic, strong) NSData * image;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * raDec;
@property (nonatomic, strong) NSString *info;

- (instancetype) initWithDictionary: (NSDictionary *) dataDictionary;

@end
