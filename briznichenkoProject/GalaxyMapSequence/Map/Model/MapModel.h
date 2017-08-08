//
//  MapModel.h
//  briznichenkoProject
//
//  Created by briznichenko on 18/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapProtocols.h"

@class CelestialBodyEntity;
@interface MapModel : NSObject
<MapModelProtocol>

@property (atomic, strong) NSData *data;
@property (atomic, strong) CelestialBodyEntity *bodyEntity;

- (instancetype) initModelWithData;
- (void) imageryForObjectWithName: (NSString *)objectName completion: (void (^)(NSArray *imageryArray)) completion;

@end
