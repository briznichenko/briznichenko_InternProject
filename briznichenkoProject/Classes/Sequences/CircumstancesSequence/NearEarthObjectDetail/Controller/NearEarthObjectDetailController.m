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
                                                 name:@"SaveNearEarthObjectEntity"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:@"PresentNearEarthObjectSharingController"
                                               object:nil];
}

- (void) receiveNotification:(NSNotification *) notification
{
    if ([notification.name isEqualToString:@"SaveNearEarthObjectEntity"])
        [self saveNearEarthEventEntity];
    else if ([notification.name isEqualToString:@"PresentNearEarthObjectSharingController"])
        [self presentShareController];
}

- (void) presentShareController
{
    self.sharingController = [[SharingController alloc] initAndAssembleWithShareURL:self.nearEarthObjectDetailModel.objectEntity.nasa_jpl_url];
    self.sharingController.sharingViewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self.nearEarthObjectDetailViewController presentViewController:self.sharingController.sharingViewController animated:YES completion:^{
        self.sharingController.sharingViewController.sharedText = self.nearEarthObjectDetailModel.objectEntity.name;
    }];
}

- (void) saveNearEarthEventEntity
{
    [self.nearEarthObjectDetailModel saveNearEarthObject:^(BOOL saved) {
        if(saved)
            [self.nearEarthObjectDetailViewController showSavedAlert];
        else
            NSLog(@"Failure saving NearEarthObjectEntity");
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
