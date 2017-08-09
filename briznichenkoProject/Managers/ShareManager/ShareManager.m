//
//  ShareManager.m
//  briznichenkoProject
//
//  Created by briznichenko on 8/9/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "ShareManager.h"
//#import <TwitterKit/TwitterKit.h>

@implementation ShareManager

#pragma mark -- Singleton Methods

+ (id)sharedManager
{
    static ShareManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (id) init
{
    if (self = [super init])
    {
        [self makeManager];
    }
    return self;
}

- (void) makeManager
{
    [self initTwitter];
}

- (void) initTwitter
{
//    TWTRLogInButton *logInButton = [TWTRLogInButton buttonWithLogInCompletion:^(TWTRSession *session, NSError *error) {
//        if (session) {
//            NSLog(@"signed in as %@", [session userName]);
//        } else {
//            NSLog(@"error: %@", [error localizedDescription]);
//        }
//    }];
//    logInButton.center = self.view.center;
//    [self.view addSubview:logInButton];
    
//    [[Twitter sharedInstance] startWithConsumerKey:@"TsrU3HY9rNLtR4OQhiLKIoHtU" consumerSecret:@"KZlqJwPZL1bjpLRJSBVjZXEvgCk4KggeldHKOeQ7l8ooi0Fjuo"];
}

@end
