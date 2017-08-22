//
//  WeatherScreenViewController.m
//  briznichenkoProject
//
//  Created by briznichenko on 21/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "WeatherScreenViewController.h"

@implementation WeatherScreenViewController

#pragma mark - ViewController lifecycle methods

- (void)viewDidLoad {
	[super viewDidLoad];
}

-(void)setupViewControllerWithData:(NSData *)data
{
    self.weatherScreenView = [[WeatherScreenView alloc] initAndInstallIntoSuperView: self.view];
    [self makeBarButtons];
    self.weatherScreenView.visibleStarsImageView.image = [UIImage imageWithData:data];
    [self makeWeatherUIFromDictionary];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
}

- (void) makeWeatherUIFromDictionary
{
    NSLog(@"%@", self.weatherDictionary);
    
//    self.weatherScreenView.humidityLabel.text = [self.weatherDictionary valueForKey:@"humidity"];
//    self.weatherScreenView.pressureLabel       = [UILabel new];
//    self.weatherScreenView. avgTemperatureLabel = [UILabel new];
//    self.weatherScreenView. maxTemperatureLabel = [UILabel new];
//    self.weatherScreenView.minTemperatureLabel = [UILabel new];
//    self.weatherScreenView.sunsetLabel         = [UILabel new];
//    self.weatherScreenView.sunriseLabel        = [UILabel new];
//    self.weatherScreenView. cloudsLevelLabel    = [UILabel new];
//    self.weatherScreenView.windSpeedLabel      = [UILabel new];
//    self.weatherScreenView. visibilityLabel     = [UILabel new];
}


- (void) makeBarButtons
{
    UIBarButtonItem *eventsButton = [[UIBarButtonItem alloc] initWithTitle:@"Events"
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:nil];
    
    UIBarButtonItem *objectsButton = [[UIBarButtonItem alloc] initWithTitle:@"Objects"
                                                                     style:UIBarButtonItemStyleDone
                                                                    target:self
                                                                    action:nil];
    self.navigationController.navigationBar.topItem.rightBarButtonItems = @[eventsButton, objectsButton];
}

@end
