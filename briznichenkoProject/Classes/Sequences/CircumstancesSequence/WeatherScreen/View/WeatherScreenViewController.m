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
}

@end
