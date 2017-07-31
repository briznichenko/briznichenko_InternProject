//
//  SplashController.h
//  briznichenkoProject
//
//  Created by briznichenko on 17/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SplashProtocols.h"

@class RootNavigationController;
@class SplashViewController;
@class SplashModel;

@interface SplashController : NSObject
<SplashViewControllerProtocol, SplashControllerProtocol>

@property (nonatomic, strong) SplashViewController* splashViewController;
@property (nonatomic, strong) SplashModel* splashModel;
@property (nonatomic, strong) RootNavigationController *rootNavigationController;
@property (nonatomic, strong) SplashController *selfReference;

-(instancetype) initAndAssemble;

@end
