//
//  MapMapProtocols.h
//  briznichenkoProject
//
//  Created by briznichenko on 18/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MapControllerProtocol <NSObject>

@optional
- (instancetype) initControllerWithData;

@end

@protocol MapViewControllerProtocol <NSObject>

-(void)setupViewControllerWithData:(NSData *)data;

@end

@protocol MapModelProtocol <NSObject>

-(void) getCelestialDataByRa:(float)ra Dec:(float)dec FOV: (float) fov;

@end

