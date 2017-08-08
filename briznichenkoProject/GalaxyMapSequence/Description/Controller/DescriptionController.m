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
}

- (void) receiveNotification:(NSNotification *) notification
{
    if ([notification.name isEqualToString:@"SaveSpaceObjectEntity"])
        [self.descriptionModel saveSpaceObjectEntity];
    else if ([notification.name isEqualToString:@"SavedSpaceObjectEntity"])
        [self.descriptionViewController showSavedAlert];
}



- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
