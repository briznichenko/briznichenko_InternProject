//
//  GalleryController.m
//  briznichenkoProject
//
//  Created by briznichenko on 31/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "GalleryController.h"


@implementation GalleryController

-(instancetype) initAndAssemble
{
	self = [super init];
	if(self)
	{
		self.galleryViewController = [GalleryViewController new];
		self.galleryModel = [[GalleryModel alloc] initWithData];
        [self setupViewControllerWithData: self.galleryModel.data];
	}	
	return self;
}

#pragma mark -- Routing

- (void)setupViewControllerWithData:(NSData *)data {
    [self.galleryViewController setupViewControllerWithData: data];
}

@end
