//
//  DescriptionModel.h
//  briznichenkoProject
//
//  Created by briznichenko on 31/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DescriptionProtocols.h"

@class CelestialBodyEntity;
@interface DescriptionModel : NSObject
<DescriptionModelProtocol>

@property (atomic, strong) NSData *data;
@property (nonatomic, strong) CelestialBodyEntity *bodyEntity;

- (instancetype) initWithData;
- (void) saveSpaceObjectEntity;

@end
