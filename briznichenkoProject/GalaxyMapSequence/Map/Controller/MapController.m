//
//  MapController.m
//  briznichenkoProject
//
//  Created by briznichenko on 18/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "MapController.h"
#import "DescriptionController.h"
#import "GalleryController.h"
#import "CelestialBodyEntity.h"

@implementation MapController

-(instancetype) initAndAssemble
{
	self = [super init];
	if(self)
	{
		self.mapViewController = [MapViewController new];
		self.mapModel = [[MapModel alloc] initModelWithData];
        [self setupViewControllerWithData:self.mapModel.data];
        [self subscribeToNotifications];
	}	
	return self;
}

-(void)setupViewControllerWithData:(NSData *)data
{
    [self.mapViewController setupViewControllerWithData:data];
}

-(void)getCelestialDataByRa:(float)ra Dec:(float)dec FOV:(float)fov
{
    [self.mapModel getCelestialDataByRa:ra Dec:dec FOV:fov];
}

# pragma mark -- Data routing

- (void) subscribeToNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:@"celBodyEntityRequest"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:@"gotCelestialData"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:@"presentDescriptionController"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:@"presentGalleryController"
                                               object:nil];
}

- (void) receiveNotification:(NSNotification *) notification
{
    if ([notification.name isEqualToString:@"celBodyEntityRequest"])
    {
        NSArray *receivedArray = notification.object;
        NSNumber *ra = receivedArray[0];
        NSNumber *dec = receivedArray[1];
        NSNumber *fov = receivedArray[2];
        [self getCelestialDataByRa: ra.floatValue
                                 Dec: dec.floatValue
                                 FOV: fov.floatValue];
    }
    else if ([notification.name isEqualToString:@"gotCelestialData"])
    {
        self.mapViewController.celestialBodyData = notification.object;
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           [self.mapViewController presentObjectPopup];
                       });
    }
    else if ([notification.name isEqualToString:@"presentDescriptionController"])
    {
        [self presentDescriptionViewController];
    }
    else if ([notification.name isEqualToString:@"presentGalleryController"])
    {
        [self presentGalleryViewController: notification.object];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -- Routing

- (void) presentDescriptionViewController
{
    self.descriptionController = [[DescriptionController alloc] initAndAssembleWithData: self.mapModel.bodyEntity];
    self.descriptionController.descriptionViewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    
    [self.mapViewController presentViewController:self.descriptionController.descriptionViewController animated:YES completion:^{}];
}

- (void) presentGalleryViewController : (UIImage *) sdssImage
{
    self.galleryController = [[GalleryController alloc] initAndAssembleWithInititalArray:@[self.mapModel.bodyEntity.bodyName, sdssImage ? sdssImage : [UIImage new]]];

    [self.mapViewController.navigationController pushViewController: self.galleryController.galleryViewController animated:YES];
}

@end
