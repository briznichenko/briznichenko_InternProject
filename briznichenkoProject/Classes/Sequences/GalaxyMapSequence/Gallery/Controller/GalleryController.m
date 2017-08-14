//
//  GalleryController.m
//  briznichenkoProject
//
//  Created by briznichenko on 31/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "GalleryController.h"
#import "ViewerController.h"

@implementation GalleryController

-(instancetype) initAndAssembleWithInititalArray:(NSArray *)array
{
	self = [super init];
	if(self)
	{
		self.galleryViewController = [GalleryViewController new];
        self.galleryModel = [[GalleryModel alloc] initWithData: array];
        
        [self setupViewControllerWithData: self.galleryModel.data];
        [self subscribeToNotifications];
	}	
	return self;
}

- (void)setupViewControllerWithData:(NSData *)data {
    [self.galleryViewController setupViewControllerWithData: data];
}

#pragma mark -- Routing

-(void) subscribeToNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:@"presentViewerController"
                                               object:nil];
}

- (void) receiveNotification:(NSNotification *) notification
{
    if ([notification.name isEqualToString:@"presentViewerController"])
    {
        [self presentViewerControllerWithImage: [UIImage imageWithData: notification.object]];
    }
}

- (void) presentViewerControllerWithImage: (UIImage*) image
{
    self.viewerController = [[ViewerController alloc] initAndAssemble];
    //
    self.viewerController.viewerViewController.viewerView.viewedImageView.image = image;
    //
    [self.galleryViewController.navigationController pushViewController:self.viewerController.viewerViewController animated:YES];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

@end
