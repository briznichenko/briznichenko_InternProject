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
    [self.descriptionModel extractAndDownloadImageFromEntity:^(NSData *fetchedData) {
        [self.descriptionViewController makeObjectImage: fetchedData];
    }];
}

#pragma mark -- Routing

- (void) subscribeToNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:@"presentGalleryController"
                                               object:nil];
}

- (void) receiveNotification:(NSNotification *) notification
{
    if ([notification.name isEqualToString:@"presentGalleryController"])
    {
        [self presentGalleryViewController];
    }
}

- (void) presentGalleryViewController
{
    [self.descriptionViewController dismissViewControllerAnimated:YES completion:^{
        
        self.galleryController = [[GalleryController alloc] initAndAssembleWithIninitalArray:@[self.descriptionModel.bodyEntity.bodyName,
                                                                                               self.descriptionViewController.descriptionView.objectImageView.image]];
        [self.descriptionViewController.navigationController pushViewController: self.galleryController.galleryViewController animated:YES];
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
