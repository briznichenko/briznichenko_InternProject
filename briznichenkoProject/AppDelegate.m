//
//  AppDelegate.m
//  briznichenkoProject
//
//  Created by briznichenko on 7/17/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "AppDelegate.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.window.rootViewController = (UIViewController *)[[SplashController alloc] initAndAssemble].splashViewController;
    
    [self.window makeKeyAndVisible];
    return YES;
}


@end
