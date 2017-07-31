//
//  RootNavigationController.m
//  briznichenkoProject
//
//  Created by briznichenko on 7/25/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "RootNavigationController.h"
#import "SideMenuController.h"
#import "MapController.h"

@interface RootNavigationController ()

@end

@implementation RootNavigationController

-(instancetype)initWithInitialViewController
{
    self = [super init];
    if(self)
    {
        self.sideMenuController = [[SideMenuController alloc] initAndAssemble];
        [self addChildViewController: [self.sideMenuController presentMapController].mapViewController];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if(self.viewControllers.count == 1)
    {
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Menu"
                                                                       style:UIBarButtonItemStyleDone
                                                                      target:self
                                                                      action:@selector(presentSideMenu:)];
//        [backButton setBackgroundImage:[UIImage imageNamed:@"Icon-App-76x76"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        
        self.navigationBar.topItem.leftBarButtonItem = backButton;
        self.navigationItem.hidesBackButton = NO;
        
        [self.navigationBar setFrame: CGRectMake(0, 0, 100, 50)];
        self.navigationBar.barTintColor = [UIColor colorWithRed:0.0f green:0.07450980392f blue:0.2f alpha:1.0f];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Navigation

-(void) presentSideMenu:(id)sender
{
    self.sideMenuController.sideMenuViewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    self.sideMenuController.sideMenuViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:self.sideMenuController.sideMenuViewController animated:YES completion:^{}];
}

@end
