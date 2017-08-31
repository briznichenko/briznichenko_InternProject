//
//  WeatherScreenModel.h
//  briznichenkoProject
//
//  Created by briznichenko on 21/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "WeatherScreenProtocols.h"

@interface WeatherScreenModel : NSObject
<WeatherScreenModelProtocol, CLLocationManagerDelegate>

@property (atomic, strong) NSData *data;

- (instancetype) initWithData;
- (void) getVisibleStars:(void (^)(NSData *imageData))completionBlock;
- (void) getWeatherData: (void (^) (NSDictionary *weatherData)) completion;
- (NSString *) returnLocationString;
@end
