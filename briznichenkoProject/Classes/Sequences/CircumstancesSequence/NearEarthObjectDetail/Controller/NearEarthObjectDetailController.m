//
//  NearEarthObjectDetailController.m
//  briznichenkoProject
//
//  Created by briznichenko on 23/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "NearEarthObjectDetailController.h"
#import "SharingController.h"

@implementation NearEarthObjectDetailController

-(instancetype) initAndAssemble
{
	self = [super init];
	if(self)
	{
		self.nearEarthObjectDetailViewController = [NearEarthObjectDetailViewController new];
        self.nearEarthObjectDetailModel = [[NearEarthObjectDetailModel alloc] initWithData];
        [self subscribeToNotifications];
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

- (void) subscribeToNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:@"shareNearEarthObject"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:@"saveNearEarthObject"
                                               object:nil];
}

- (void) receiveNotification:(NSNotification *) notification
{
    if ([notification.name isEqualToString:@"shareNearEarthObject"])
    {
        [self presentSharingController];
    }
    else if ([notification.name isEqualToString:@"saveNearEarthObject"])
    {
        [self.nearEarthObjectDetailModel saveNearEarthObjectEntity:^(BOOL saved) {
            if(saved)
                [self.nearEarthObjectDetailViewController showSavedAlert];
        }];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -- Routing methods

- (void)presentSharingController
{
    self.sharingController = [[SharingController alloc] initAndAssembleWithShareURL:@""];
    self.sharingController.sharingViewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self.nearEarthObjectDetailViewController presentViewController:self.sharingController.sharingViewController animated:YES completion:^{
        //TODO
    }];
}

@end
