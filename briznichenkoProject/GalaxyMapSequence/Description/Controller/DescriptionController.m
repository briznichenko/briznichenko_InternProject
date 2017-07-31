//
//  DescriptionController.m
//  briznichenkoProject
//
//  Created by briznichenko on 31/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "DescriptionController.h"


@implementation DescriptionController

-(instancetype) initAndAssemble
{
	self = [super init];
	if(self)
	{
		self.descriptionViewController = [DescriptionViewController new];
		self.descriptionModel = [[DescriptionModel alloc] initWithData];
        
        [self setupViewControllerWithData:self.descriptionModel.data];
	}	
	return self;
}

#pragma mark -- Routing

- (void)setupViewControllerWithData:(NSData *)data {
    [self.descriptionViewController setupViewControllerWithData:data];
    self.descriptionViewController.bodyEntity = self.descriptionModel.bodyEntity;
}

@end
