//
//  NearEarthObjectsModel.h
//  briznichenkoProject
//
//  Created by briznichenko on 23/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NearEarthObjectsProtocols.h"


@interface NearEarthObjectsModel : NSObject
<NearEarthObjectsModelProtocol>

@property (atomic, strong) NSData *data;

- (instancetype) initWithData;
- (void) getNearbyObjectsFor:(NSDate *) startDate endDate:(NSDate *) endDate completion:(void (^)(NSDictionary *objects))completion;
- (void) getSingleNearbyObjectByObjectID:(NSString *)objectID completion:(void (^)(NSDictionary *description))completion;

@end
