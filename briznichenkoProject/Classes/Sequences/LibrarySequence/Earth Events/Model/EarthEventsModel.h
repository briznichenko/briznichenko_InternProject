//
//  EarthEventsModel.h
//  briznichenkoProject
//
//  Created by briznichenko on 8/30/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EarthEventsModel : NSObject

@property (nonatomic, strong) NSArray *earthEvents;

- (void) formatEntities;

@end
