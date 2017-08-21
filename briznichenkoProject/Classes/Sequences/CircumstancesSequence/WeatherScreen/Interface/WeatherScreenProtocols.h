//
//  WeatherScreenWeatherScreenProtocols.h
//  briznichenkoProject
//
//  Created by briznichenko on 21/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WeatherScreenControllerProtocol <NSObject>

@optional
- (instancetype) initControllerWithData;

@end

@protocol WeatherScreenViewControllerProtocol <NSObject>

-(void)setupViewControllerWithData:(NSData *)data;

@end

@protocol WeatherScreenModelProtocol <NSObject>

@end
