//
//  NearEarthEventsController.m
//  briznichenkoProject
//
//  Created by briznichenko on 23/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "NearEarthEventsController.h"


@implementation NearEarthEventsController

-(instancetype) initAndAssemble
{
	self = [super init];
	if(self)
	{
		self.nearEarthEventsViewController = [NearEarthEventsViewController new];
		self.nearEarthEventsModel = [[NearEarthEventsModel alloc] initWithData];
	}	
	return self;
}

-(void)setupViewControllerWithData:(NSData *)data
{
    [self.nearEarthEventsViewController setupViewControllerWithData:data];
}

#pragma mark -- Routing

@end
