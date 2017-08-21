//
//  SideMenuController.m
//  briznichenkoProject
//
//  Created by briznichenko on 25/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "SideMenuController.h"
#import "RootNavigationController.h"

@implementation SideMenuController
{
    NSArray *sideMenuEntries;
}

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
    sideMenuEntries = [[NSArray alloc] initWithObjects:@"Galaxy Map", @"Earth Map", @"My Conditions", @"My Library", nil];
    [self subscribeToNotifications];
}

- (void) subscribeToNotifications
{
    for(int i = 0; i < sideMenuEntries.count; i++)
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveNotification:)
                                                     name:sideMenuEntries[i]
                                                   object:nil];
}

#pragma mark -- Routing

- (void) receiveNotification: (NSNotification *) notification
{
    switch ([sideMenuEntries indexOfObject:notification.name]) {
        case 0:
            [self.rootNavigationController presentMapController];
             [self.sideMenuViewController dismissViewControllerAnimated:YES completion:^{}];
            break;
        case 1:
            [self.rootNavigationController presentEarthScreenController];
            [self.sideMenuViewController dismissViewControllerAnimated:YES completion:^{}];
            break;
        case 2:
            [self.rootNavigationController presentWeatherScreenController];
            [self.sideMenuViewController dismissViewControllerAnimated:YES completion:^{}];
            break;
        case 3:
            [self.sideMenuViewController dismissViewControllerAnimated:YES completion:^{}];
            break;
            
        default:
            break;
    }
}

#pragma mark -- dealloc

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
