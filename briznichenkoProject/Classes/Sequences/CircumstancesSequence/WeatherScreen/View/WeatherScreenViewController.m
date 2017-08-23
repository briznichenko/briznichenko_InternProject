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
    float topY = [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.frame.size.height;
    self.weatherScreenView = [[WeatherScreenView alloc] initAndInstallIntoSuperView: self.view topY:topY];
    [self makeBarButtons];
    self.weatherScreenView.visibleStarsImageView.image = [UIImage imageWithData:data];
}

- (void) updateWeatherData: (NSDictionary *)weatherData
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"HH:MM:SS";
    NSString *sunsetString = [formatter stringFromDate:
                              [NSDate dateWithTimeIntervalSince1970:
                               [NSString stringWithFormat:@"%@", [[weatherData valueForKey:@"sys"] valueForKey:@"sunset"]].doubleValue]];
    NSString *sunriseString = [formatter stringFromDate:
                               [NSDate dateWithTimeIntervalSince1970:
                                [NSString stringWithFormat:@"%@", [[weatherData valueForKey:@"sys"] valueForKey:@"sunrise"]].doubleValue]];
    NSString *tempString = [NSString stringWithFormat:@"%f C",
                            [NSString stringWithFormat:@"%@",
                             [[weatherData valueForKey:@"main"] valueForKey:@"temp"]].floatValue - 273.15];
    NSString *maxTempString = [NSString stringWithFormat:@"%f C",
                               [NSString stringWithFormat:@"%@",
                                [[weatherData valueForKey:@"main"] valueForKey:@"temp_max"]].floatValue - 273.15];
    NSString *minTempString = [NSString stringWithFormat:@"%f C",
                               [NSString stringWithFormat:@"%@",
                                [[weatherData valueForKey:@"main"] valueForKey:@"temp_min"]].floatValue - 273.15];;
    
    self.weatherScreenView.humidityLabel.text = [NSString stringWithFormat:@"%@%%", [[weatherData valueForKey:@"main"] valueForKey:@"humidity"]];
    self.weatherScreenView.pressureLabel.text = [NSString stringWithFormat:@"%@ hPa", [[weatherData valueForKey:@"main"] valueForKey:@"pressure"]];
    self.weatherScreenView.avgTemperatureLabel.text = tempString;
    self.weatherScreenView.maxTemperatureLabel.text = maxTempString;
    self.weatherScreenView.minTemperatureLabel.text = minTempString;
    self.weatherScreenView.sunsetLabel.text = sunsetString;
    self.weatherScreenView.sunriseLabel.text = sunriseString;
    self.weatherScreenView.cloudsLevelLabel.text = [NSString stringWithFormat:@"%@", [[weatherData valueForKey:@"clouds"]valueForKey:@"all"]];
    self.weatherScreenView.windSpeedLabel.text = [NSString stringWithFormat:@"%@ mps", [[weatherData valueForKey:@"wind"] valueForKey:@"speed"]];
    self.weatherScreenView.visibilityLabel.text = [NSString stringWithFormat:@"%@ m", [weatherData valueForKey:@"visibility"]];
    
    NSString *weatherURLString = [NSString stringWithFormat:@"http://openweathermap.org/img/w/%@.png",[[weatherData valueForKey:@"weather"] valueForKey:@"icon"]];
    weatherURLString = [[weatherURLString stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    weatherURLString = [[weatherURLString stringByReplacingOccurrencesOfString:@"(" withString:@""] stringByReplacingOccurrencesOfString:@")" withString:@""];
    NSURL *weatherURL = [[NSURL URLWithString: weatherURLString] URLByStandardizingPath];
    UIImage *weatherImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:weatherURL]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.weatherScreenView.weatherImage.image = weatherImage;
        [self.weatherScreenView.weatherImage setNeedsDisplay];
    });
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
