//
//  DescriptionController.m
//  briznichenkoProject
//
//  Created by briznichenko on 31/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "DescriptionController.h"


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
	}	
	return self;
}

#pragma mark -- Routing

- (void)setupViewControllerWithData:(id) data {
    [self.descriptionViewController setupViewControllerWithData: data];
    [self.descriptionModel extractAndDownloadImageFromEntity:^(NSData *fetchedData) {
        [self.descriptionViewController makeObjectImage: fetchedData];
    }];
}

@end
