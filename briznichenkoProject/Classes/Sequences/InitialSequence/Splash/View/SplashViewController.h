//
//  SplashViewController.h
//  briznichenkoProject
//
//  Created by briznichenko on 17/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SplashProtocols.h"
#import "SplashView.h"

@interface SplashViewController : UIViewController
<SplashViewControllerProtocol>

@property (nonatomic, strong) SplashView* splashView;

@end
