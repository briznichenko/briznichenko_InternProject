//
//  SplashController.m
//  briznichenkoProject
//
//  Created by briznichenko on 17/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "SplashController.h"
#import "SideMenuController.h"
#import "SplashViewController.h"
#import "SplashModel.h"
#import "MapController.h"
#import "SplashProtocols.h"
#import "RootNavigationController.h"

@implementation SplashController

-(instancetype) initAndAssemble
{
	self = [super init];
	if(self)
	{
        self.selfReference = self;
		self.splashViewController = [SplashViewController new];
		self.splashModel = [[SplashModel alloc] initWithData];
        [self setupViewControllerWithData:self.splashModel.data];
        [self setupController];
	}
	return self;
}

-(void)setupController
{
    [self presentRootNavigationController];
}

-(void)setupViewControllerWithData:(NSData *)data
{
    [self.splashViewController setupViewControllerWithData:data];
}

#pragma mark -- Routing

- (void) presentRootNavigationController
{
    self.rootNavigationController = [[RootNavigationController alloc] initWithInitialViewController];
    [self addObserver:self forKeyPath:@"rootNavigationController.sideMenuController.mapController.mapViewController.isReady" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"rootNavigationController.sideMenuController.mapController.mapViewController.isReady"])
    {
        if (self.rootNavigationController.sideMenuController.mapController.mapViewController.isReady)
        {
            [self.splashViewController presentViewController:self.rootNavigationController animated:YES completion:
             ^{
                 self.selfReference = nil;
                [self removeObserver:self forKeyPath:@"rootNavigationController.sideMenuController.mapController.mapViewController.isReady"];
             }];
        }
    }
}


@end
