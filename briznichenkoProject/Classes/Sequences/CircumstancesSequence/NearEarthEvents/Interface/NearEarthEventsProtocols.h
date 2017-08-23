//
//  NearEarthEventsNearEarthEventsProtocols.h
//  briznichenkoProject
//
//  Created by briznichenko on 23/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NearEarthEventsControllerProtocol <NSObject>

@optional
- (instancetype) initControllerWithData;

@end

@protocol NearEarthEventsViewControllerProtocol <NSObject>

-(void)setupViewControllerWithData:(NSData *)data;

@end

@protocol NearEarthEventsModelProtocol <NSObject>

@end
