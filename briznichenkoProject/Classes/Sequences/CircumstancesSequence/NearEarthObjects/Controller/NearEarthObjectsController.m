//
//  NearEarthObjectsController.m
//  briznichenkoProject
//
//  Created by briznichenko on 23/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "NearEarthObjectsController.h"
#import "NearEarthObjectDetailController.h"


@implementation NearEarthObjectsController

-(instancetype) initAndAssemble
{
	self = [super init];
	if(self)
	{
		self.nearEarthObjectsViewController = [NearEarthObjectsViewController new];
		self.nearEarthObjectsModel = [[NearEarthObjectsModel alloc] initWithData];
        [self subscribeToNotifications];
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

- (void) subscribeToNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:@"requestNearEarthObjectDetail"
                                               object:nil];
}

- (void) receiveNotification:(NSNotification *) notification
{
    if ([notification.name isEqualToString:@"requestNearEarthObjectDetail"])
    {
        [self requestNearEarthObjectDetailForID: notification.object];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) requestNearEarthObjectDetailForID: (NSString *) objectID
{
    [self.nearEarthObjectsModel getSingleNearbyObjectByObjectID:objectID completion:^(bool finished) {
        if(finished)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentNearEarthObjectDetailControlller];
            });
        }
    }];
}

- (void) presentNearEarthObjectDetailControlller
{
    self.nearEarthObjectsDetailController = [[NearEarthObjectDetailController alloc] initAndAssemble];
    self.nearEarthObjectsDetailController.nearEarthObjectDetailModel.objectEntity = self.nearEarthObjectsModel.objectEntity;
    [self.nearEarthObjectsDetailController setupWithEntity];
    [self.nearEarthObjectsViewController.navigationController pushViewController:self.nearEarthObjectsDetailController.nearEarthObjectDetailViewController animated:YES];
}

@end
