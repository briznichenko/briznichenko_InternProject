//
//  NearEarthEventDetailController.m
//  briznichenkoProject
//
//  Created by briznichenko on 23/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "NearEarthEventDetailController.h"


@implementation NearEarthEventDetailController

-(instancetype) initAndAssembleWithEventURL: (NSURL *) eventURL;
{
	self = [super init];
	if(self)
	{
		self.nearEarthEventDetailViewController = [NearEarthEventDetailViewController new];
		self.nearEarthEventDetailModel = [[NearEarthEventDetailModel alloc] initWithData];
        self.nearEarthEventDetailModel.baseURL = eventURL;
        [self.nearEarthEventDetailModel parseDataFromEventHTML:^(BOOL finished) {
            [self setupViewControllerWithData: self.nearEarthEventDetailModel.data];
        }];
	}	
	return self;
}

-(void)setupViewControllerWithData:(NSData *)data
{
    self.nearEarthEventDetailViewController.eventEntity = self.nearEarthEventDetailModel.eventEntity;
    [self.nearEarthEventDetailViewController setupViewControllerWithData: data];
}


#pragma mark -- Routing

@end
