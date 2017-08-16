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
#import "MapViewController.h"
#import "EarthScreenViewController.h"
//#import "header"
//#import "header"


@implementation RootNavigationController

-(instancetype)initWithInitialViewController
{
    self = [super init];
    if(self)
    {
        self.sideMenuController = [[SideMenuController alloc] initAndAssemble];
        self.sideMenuController.rootNavigationController = self;
        [self presentMapController];
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
        self.navigationBar.topItem.leftBarButtonItem = backButton;
        self.navigationItem.hidesBackButton = NO;
        
        self.navigationBar.barTintColor = [UIColor colorWithRed:0.0f green:0.07450980392f blue:0.2f alpha:1.0f];
    }

}

- (void) remakeViewToFitScreen
{
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    CGRect mainScreenBounds = [[UIScreen mainScreen] bounds];
    CGRect windowFrame = CGRectMake(mainScreenBounds.origin.x,
                                    mainScreenBounds.origin.y + statusBarFrame.size.height,
                                    mainScreenBounds.size.width,
                                    mainScreenBounds.size.height - statusBarFrame.size.height);
    
    self.view.frame = windowFrame;
}

#pragma mark - Navigation

-(void) presentSideMenu:(id)sender
{
    self.sideMenuController.sideMenuViewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:self.sideMenuController.sideMenuViewController animated:NO completion:nil];
}

- (void) presentMapController
{
    if(self.viewControllers.count == 0)
    {
        self.mapController = [[MapController alloc] initAndAssemble];
        [self addChildViewController:self.mapController.mapViewController];
    }
    else if([self.viewControllers[0] isKindOfClass:[MapViewController class]])
        [self.sideMenuController.sideMenuViewController dismissViewControllerAnimated:YES completion:nil];
    else
    {
        self.mapController = [[MapController alloc] initAndAssemble];
        NSArray *newControllerStack = @[self.mapController.mapViewController];
        [self setViewControllers:newControllerStack animated:YES];
    }
}

- (void) presentEarthScreenController
{
    if([self.viewControllers[0] isKindOfClass:[EarthScreenViewController class]])
        [self.sideMenuController.sideMenuViewController dismissViewControllerAnimated:YES completion:nil];
    else
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"EarthSequenceStoryboard" bundle:nil];
        self.earthScreenViewController = [storyboard instantiateViewControllerWithIdentifier:@"EarthScreenViewController"];
//        self.earthScreenViewController = [[EarthScreenViewController alloc] in]
        NSArray *newControllerStack = @[self.earthScreenViewController];
        [self setViewControllers:newControllerStack animated:YES];
    }
}

@end
