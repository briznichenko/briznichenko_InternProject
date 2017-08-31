//
//  EarthEventModel.h
//  briznichenkoProject
//
//  Created by briznichenko on 8/18/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EarthEventEntity.h"

@interface EarthEventModel : NSObject

@property (nonatomic, strong) EarthEventEntity *eventEntity;

- (instancetype) initWithData;
- (void) saveEvent: (void (^) (BOOL saved)) completionBlock;

@end
