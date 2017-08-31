//
//  WeatherScreenViewController.h
//  briznichenkoProject
//
//  Created by briznichenko on 21/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherScreenProtocols.h"
#import "WeatherScreenView.h"

@interface WeatherScreenViewController : UIViewController
<WeatherScreenViewControllerProtocol>

@property (nonatomic, strong) WeatherScreenView* weatherScreenView;

- (void) updateWeatherData: (NSDictionary *)weatherData;

@end
