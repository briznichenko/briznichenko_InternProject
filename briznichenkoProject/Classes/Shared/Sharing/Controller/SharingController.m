//
//  SharingController.m
//  briznichenkoProject
//
//  Created by briznichenko on 09/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "SharingController.h"


@implementation SharingController

-(instancetype) initAndAssembleWithShareURL:(NSString *)shareURL
{
	self = [super init];
	if(self)
	{
		self.sharingViewController = [SharingViewController new];
		self.sharingModel = [[SharingModel alloc] initWithData];
        self.sharingViewController.shareURLString = shareURL;
        [self setupViewControllerWithData: self.sharingModel.data];
	}	
	return self;
}

- (void)setupViewControllerWithData: (NSData *) data
{
    [self.sharingViewController setupViewControllerWithData:data];
}

#pragma mark -- Routing



@end
