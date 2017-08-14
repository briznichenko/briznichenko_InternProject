//
//  AppDelegate.m
//  briznichenkoProject
//
//  Created by briznichenko on 7/17/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <TwitterKit/TwitterKit.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.window.rootViewController = (UIViewController *)[[SplashController alloc] initAndAssemble].splashViewController;
    
//    [[Twitter sharedInstance] startWithConsumerKey:@"TsrU3HY9rNLtR4OQhiLKIoHtU" consumerSecret:@"KZlqJwPZL1bjpLRJSBVjZXEvgCk4KggeldHKOeQ7l8ooi0Fjuo"];
//    [[FBSDKApplicationDelegate sharedInstance] application:application
//                             didFinishLaunchingWithOptions:launchOptions];
    
    [self.window makeKeyAndVisible];
    return YES;
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    if([url.absoluteString containsString:@"twitterkit"])
        return [[Twitter sharedInstance] application:app openURL:url options:options];
    return [[FBSDKApplicationDelegate sharedInstance] application:app
                                                          openURL:url
                                                sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                                       annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];;
}

@end
