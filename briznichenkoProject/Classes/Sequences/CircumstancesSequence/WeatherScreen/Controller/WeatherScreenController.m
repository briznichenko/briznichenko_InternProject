//
//  WeatherScreenController.m
//  briznichenkoProject
//
//  Created by briznichenko on 21/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "WeatherScreenController.h"


@implementation WeatherScreenController

-(instancetype) initAndAssemble
{
	self = [super init];
	if(self)
	{
		self.weatherScreenViewController = [WeatherScreenViewController new];
		self.weatherScreenModel = [[WeatherScreenModel alloc] initWithData];
        [self setupViewControllerWithData:self.weatherScreenModel.data];
	}	
	return self;
}

- (void)setupViewControllerWithData:(NSData *)data {
    [self.weatherScreenModel getVisibleStars:^(NSData *imageData) {
        if(imageData){
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.weatherScreenViewController setupViewControllerWithData:imageData];
                self.weatherScreenViewController.weatherScreenView.locationLabel.text = [self.weatherScreenModel returnLocationString];
                [self.weatherScreenViewController.weatherScreenView setNeedsDisplay];
            });
            [self.weatherScreenModel getWeatherData:^(NSDictionary *weatherData) {
                if(weatherData)
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.weatherScreenViewController updateWeatherData: weatherData];
                        [self.weatherScreenViewController.weatherScreenView setNeedsDisplay];
                    });
            }];}
    }];
}

#pragma mark -- Routing

@end
