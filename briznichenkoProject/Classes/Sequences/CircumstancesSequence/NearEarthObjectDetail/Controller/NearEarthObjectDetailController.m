//
//  NearEarthObjectDetailController.m
//  briznichenkoProject
//
//  Created by briznichenko on 23/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "NearEarthObjectDetailController.h"


@implementation NearEarthObjectDetailController

-(instancetype) initAndAssemble
{
	self = [super init];
	if(self)
	{
		self.nearEarthObjectDetailViewController = [NearEarthObjectDetailViewController new];
        self.nearEarthObjectDetailModel = [[NearEarthObjectDetailModel alloc] initWithData];
    }
	return self;
}

-(void) setupWithEntity
{
    [self setupViewControllerWithData:[NSData new]];
}

-(void)setupViewControllerWithData:(NSData *)data
{
    self.nearEarthObjectDetailViewController.objectEntity = self.nearEarthObjectDetailModel.objectEntity;
    [self.nearEarthObjectDetailViewController setupViewControllerWithData: data];
}

#pragma mark -- Routing

@end
