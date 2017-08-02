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
    [self remakeViewToFitScreen];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)viewDidLayoutSubviews
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
        
//        [self.navigationBar setFrame: CGRectMake(0, 0, 100, 50)];
        self.navigationBar.barTintColor = [UIColor colorWithRed:0.0f green:0.07450980392f blue:0.2f alpha:1.0f];
    }

}

- (void) remakeViewToFitScreen
{
//    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    CGRect mainScreenBounds = [[UIScreen mainScreen] bounds];
    CGRect windowFrame = CGRectMake(mainScreenBounds.origin.x,
                                    mainScreenBounds.origin.y + statusBarFrame.size.height,
                                    mainScreenBounds.size.width,
                                    mainScreenBounds.size.height - statusBarFrame.size.height);
    
    self.view.frame = windowFrame;
    
//    [NSLayoutConstraint activateConstraints:
//     @[[self.view.topAnchor constraintGreaterThanOrEqualToAnchor:self.view.window.topAnchor constant:statusBarFrame.size.height],
//       [self.view.centerXAnchor constraintEqualToAnchor:self.view.window.centerXAnchor],
//       [self.view.widthAnchor constraintEqualToAnchor:self.view.window.widthAnchor],
//       [self.view.heightAnchor constraintLessThanOrEqualToAnchor:self.view.window.heightAnchor constant:statusBarFrame.size.height]
//       ]];
}

#pragma mark - Navigation

-(void) presentSideMenu:(id)sender
{
    self.sideMenuController.sideMenuViewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    self.sideMenuController.sideMenuViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:self.sideMenuController.sideMenuViewController animated:YES completion:^{}];
}

@end
