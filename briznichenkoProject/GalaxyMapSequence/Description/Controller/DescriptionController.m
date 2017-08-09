//
//  DescriptionController.m
//  briznichenkoProject
//
//  Created by briznichenko on 31/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "DescriptionController.h"
#import "GalleryController.h"
#import "CelestialBodyEntity.h"
#import "SharingController.h"

@implementation DescriptionController

-(instancetype) initAndAssembleWithData:(id)data
{
	self = [super init];
	if(self)
	{
		self.descriptionViewController = [DescriptionViewController new];
		self.descriptionModel = [[DescriptionModel alloc] initWithData];
        self.descriptionModel.bodyEntity = data;
        
        [self setupViewControllerWithData:self.descriptionModel.bodyEntity];
        [self subscribeToNotifications];
	}	
	return self;
}

- (void)setupViewControllerWithData:(id) data {
    [self.descriptionViewController setupViewControllerWithData: data];
}

#pragma mark -- Routing

- (void) subscribeToNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:@"SaveSpaceObjectEntity"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:@"SavedSpaceObjectEntity"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:@"PresentSpaceObjectSharingController"
                                               object:nil];
}

- (void) receiveNotification:(NSNotification *) notification
{
    if ([notification.name isEqualToString:@"SaveSpaceObjectEntity"])
        [self.descriptionModel saveSpaceObjectEntity];
    else if ([notification.name isEqualToString:@"SavedSpaceObjectEntity"])
        [self.descriptionViewController showSavedAlert];
    else if ([notification.name isEqualToString:@"PresentSpaceObjectSharingController"])
        [self presentShareController];
}

-(void) presentShareController
{
    self.sharingController = [[SharingController alloc] initAndAssemble];
    self.sharingController.sharingViewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self.descriptionViewController presentViewController:self.sharingController.sharingViewController animated:YES completion:^{
        NSLog(@"%@:SHARE", self);
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
