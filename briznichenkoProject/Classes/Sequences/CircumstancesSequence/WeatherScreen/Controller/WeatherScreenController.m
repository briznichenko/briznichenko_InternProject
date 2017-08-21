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
        [self.weatherScreenModel getVisibleStars:^(bool finished) {
            
        }];
	}	
	return self;
}

- (void)setupViewControllerWithData:(NSData *)data {
    [self.weatherScreenViewController setupViewControllerWithData:data];
}

#pragma mark -- Routing

@end
