//
//  NearEarthObjectsController.m
//  briznichenkoProject
//
//  Created by briznichenko on 23/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "NearEarthObjectsController.h"


@implementation NearEarthObjectsController

-(instancetype) initAndAssemble
{
	self = [super init];
	if(self)
	{
		self.nearEarthObjectsViewController = [NearEarthObjectsViewController new];
		self.nearEarthObjectsModel = [[NearEarthObjectsModel alloc] initWithData];
        [self setupViewControllerWithData:self.nearEarthObjectsModel.data];
	}	
	return self;
}

-(void)setupViewControllerWithData:(NSData *)data
{
    [self.nearEarthObjectsModel getNearbyObjectsFor:[NSDate new] endDate:[NSDate new] completion:^(NSDictionary *objects) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.nearEarthObjectsViewController.nearEarthObjects = objects;
            [self.nearEarthObjectsViewController setupViewControllerWithData:data];
            [self.nearEarthObjectsViewController.nearEarthObjectsView.objectsTable reloadData];
        });
    }];
}

#pragma mark -- Routing



@end
