//
//  NearEarthEventDetailController.m
//  briznichenkoProject
//
//  Created by briznichenko on 23/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "NearEarthEventDetailController.h"
#import "SharingController.h"

@implementation NearEarthEventDetailController

- (instancetype) initAndAssembleWithEventURL: (NSURL * _Nullable) eventURL orEntity: (id _Nullable) entity
{
	self = [super init];
	if(self)
	{
		self.nearEarthEventDetailViewController = [NearEarthEventDetailViewController new];
		self.nearEarthEventDetailModel = [[NearEarthEventDetailModel alloc] initWithData];
        [self subscribeToNotifications];
        
        if(entity)
        {
            self.nearEarthEventDetailModel.eventEntity = entity;
            [self setupViewControllerWithData: self.nearEarthEventDetailModel.data];
        }
        else
        {
            self.nearEarthEventDetailModel.baseURL = eventURL;
            [self.nearEarthEventDetailModel parseDataFromEventHTML:^(BOOL finished) {
                [self setupViewControllerWithData: self.nearEarthEventDetailModel.data];
            }];
        }
	}	
	return self;
}

-(void)setupViewControllerWithData:(NSData *)data
{
    self.nearEarthEventDetailViewController.eventEntity = self.nearEarthEventDetailModel.eventEntity;
    [self.nearEarthEventDetailViewController setupViewControllerWithData: data];
}

#pragma mark -- Routing

- (void) subscribeToNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:@"SaveNearEarthEventEntity"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:@"PresentNearEarthEventSharingController"
                                               object:nil];
}

- (void) receiveNotification:(NSNotification *) notification
{
    if ([notification.name isEqualToString:@"SaveNearEarthEventEntity"])
        [self saveNearEarthEventEntity];
    else if ([notification.name isEqualToString:@"PresentNearEarthEventSharingController"])
        [self presentShareController];
}

- (void) presentShareController
{
    self.sharingController = [[SharingController alloc] initAndAssembleWithShareURL:self.nearEarthEventDetailModel.baseURL.absoluteString];
    self.sharingController.sharingViewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self.nearEarthEventDetailViewController presentViewController:self.sharingController.sharingViewController animated:YES completion:^{
        self.sharingController.sharingViewController.sharedText = self.nearEarthEventDetailModel.eventEntity.event_title;
    }];
}

- (void) saveNearEarthEventEntity
{
    [self.nearEarthEventDetailModel saveNearEarthEvent:^(BOOL saved) {
        if(saved)
            [self.nearEarthEventDetailViewController showSavedAlert];
        else
            NSLog(@"Failure saving NearEarthEventEntity");
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
