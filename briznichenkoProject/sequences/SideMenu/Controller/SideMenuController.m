//
//  SideMenuController.m
//  briznichenkoProject
//
//  Created by briznichenko on 25/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "SideMenuController.h"
#import "MapController.h"
//#import "header"
//#import "header"
//#import "header"

@implementation SideMenuController

-(instancetype) initAndAssemble
{
	self = [super init];
	if(self)
	{
		self.sideMenuViewController = [SideMenuViewController new];
		self.sideMenuModel = [[SideMenuModel alloc] initWithParams];
        [self.sideMenuModel getImageData:^(NSData *fetchedData) {
            [self setupViewControllerWithData: fetchedData];
        }];
	}	
	return self;
}

-(void)setupViewControllerWithData:(NSData *)data
{
    [self.sideMenuViewController setupViewControllerWithData:data];
}

#pragma mark -- Routing

- (MapController *) presentMapController
{
    self.mapController = [[MapController alloc] initAndAssemble];
    return self.mapController;
}

@end
