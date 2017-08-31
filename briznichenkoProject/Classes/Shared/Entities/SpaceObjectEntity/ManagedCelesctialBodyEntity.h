//
//  ManagedCelesctialBodyEntity.h
//  briznichenkoProject
//
//  Created by briznichenko on 8/8/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface ManagedCelesctialBodyEntity : NSManagedObject

@property (nonatomic, strong) NSData * image;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * raDec;
@property (nonatomic, strong) NSData *info;

@end
