//
//  NearEarthObjectDetailModel.h
//  briznichenkoProject
//
//  Created by briznichenko on 23/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NearEarthObjectDetailProtocols.h"


@interface NearEarthObjectDetailModel : NSObject
<NearEarthObjectDetailModelProtocol>

@property (atomic, strong) NSData *data;

- (instancetype) initWithData;

@end
