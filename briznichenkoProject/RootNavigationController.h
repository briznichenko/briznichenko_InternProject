//
//  RootNavigationController.h
//  briznichenkoProject
//
//  Created by briznichenko on 7/25/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SideMenuProtocols.h"

@class SideMenuController;
@class MapController;

@interface RootNavigationController : UINavigationController
<SideMenuControllerProtocol>

@property(nonatomic, strong) SideMenuController *sideMenuController;

- (instancetype) initWithInitialViewController;

@end
