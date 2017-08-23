//
//  NearEarthEventsModel.h
//  briznichenkoProject
//
//  Created by briznichenko on 23/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NearEarthEventsProtocols.h"


@interface NearEarthEventsModel : NSObject
<NearEarthEventsModelProtocol>

@property (atomic, strong) NSData *data;

- (instancetype) initWithData;

@end
