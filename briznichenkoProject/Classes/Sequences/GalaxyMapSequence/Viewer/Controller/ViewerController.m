//
//  ViewerController.m
//  briznichenkoProject
//
//  Created by briznichenko on 01/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "ViewerController.h"
#import "SharingController.h"


@implementation ViewerController

-(instancetype) initAndAssemble
{
	self = [super init];
	if(self)
	{
		self.viewerViewController = [ViewerViewController new];
		self.viewerModel = [[ViewerModel alloc] initWithData];
        [self setupViewControllerWithData: self.viewerModel.data];
        [self subscribeToNotifications];
	}	
	return self;
}

- (void)setupViewControllerWithData:(NSData *)data {
    [self.viewerViewController setupViewControllerWithData: data];
}

#pragma mark -- Routing

- (void) subscribeToNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:@"PresentSpaceObjectPhotoSharingController"
                                               object:nil];
}

- (void) receiveNotification:(NSNotification *) notification
{
    if ([notification.name isEqualToString:@"PresentSpaceObjectPhotoSharingController"])
        [self presentShareController];
}

-(void) presentShareController
{
    self.sharingController = [[SharingController alloc] initAndAssembleWithShareURL:@""];
    self.sharingController.sharingViewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self.viewerViewController presentViewController:self.sharingController.sharingViewController animated:YES completion:^{
        self.sharingController.sharingViewController.sharedImageData = UIImagePNGRepresentation(self.viewerViewController.viewerView.viewedImageView.image);
        NSLog(@"%@:SHARE", self);
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
