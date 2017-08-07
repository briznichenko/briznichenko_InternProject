//
//  EarthScreenController.m
//  briznichenkoProject
//
//  Created by briznichenko on 04/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "EarthScreenController.h"


@implementation EarthScreenController

-(instancetype) initAndAssemble
{
	self = [super init];
	if(self)
	{
		self.earthscreenViewController = [EarthScreenViewController new];
		self.earthscreenModel = [[EarthScreenModel alloc] initWithData];
        [self setupViewControllerWithData:self.earthscreenModel.data];
	}	
	return self;
}

-(void)setupViewControllerWithData:(NSData *)data
{
    [self.earthscreenViewController setupViewControllerWithData:data];
}

#pragma mark -- Routing

@end
