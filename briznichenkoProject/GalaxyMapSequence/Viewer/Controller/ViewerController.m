//
//  ViewerController.m
//  briznichenkoProject
//
//  Created by briznichenko on 01/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "ViewerController.h"


@implementation ViewerController

-(instancetype) initAndAssemble
{
	self = [super init];
	if(self)
	{
		self.viewerViewController = [ViewerViewController new];
		self.viewerModel = [[ViewerModel alloc] initWithData];
        [self setupViewControllerWithData: self.viewerModel.data];
	}	
	return self;
}

#pragma mark -- Routing

- (void)setupViewControllerWithData:(NSData *)data {
    [self.viewerViewController setupViewControllerWithData: data];
}

@end
