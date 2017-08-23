//
//  WeatherScreenController.m
//  briznichenkoProject
//
//  Created by briznichenko on 21/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "WeatherScreenController.h"
#import "NearEarthEventsController.h"
#import "NearEarthObjectsController.h"

@implementation WeatherScreenController

-(instancetype) initAndAssemble
{
	self = [super init];
	if(self)
	{
		self.weatherScreenViewController = [WeatherScreenViewController new];
		self.weatherScreenModel = [[WeatherScreenModel alloc] initWithData];
        [self setupViewControllerWithData:self.weatherScreenModel.data];
        [self subscribeToNotifications];
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

- (void) subscribeToNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:@"presentNearEarthEventsController"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:@"presentNearEarthObjectsController"
                                               object:nil];
}

- (void) receiveNotification:(NSNotification *) notification
{
    if ([notification.name isEqualToString:@"presentNearEarthEventsController"])
    {
        [self peresentNearEarthEventsController];
    }
    else if ([notification.name isEqualToString:@"presentNearEarthObjectsController"])
    {
        [self presentNearEarthObjectsController];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) peresentNearEarthEventsController
{
    self.nearEarthEventsController = [[NearEarthEventsController alloc] initAndAssemble];
    [self.weatherScreenViewController.navigationController pushViewController:self.nearEarthEventsController.nearEarthEventsViewController animated:YES];
}
- (void) presentNearEarthObjectsController
{
    self.nearEarthObjectsController = [[NearEarthObjectsController alloc] initAndAssemble];
    [self.weatherScreenViewController.navigationController pushViewController:self.nearEarthObjectsController.nearEarthObjectsViewController animated:YES];
}

@end
