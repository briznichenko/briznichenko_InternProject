//
//  SideMenuController.h
//  briznichenkoProject
//
//  Created by briznichenko on 25/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SideMenuViewController.h"
#import "SideMenuModel.h"

@class RootNavigationController;


@interface SideMenuController : NSObject
<SideMenuViewControllerProtocol, SideMenuControllerProtocol, SideMenuModelProtocol>

@property (nonatomic, weak) RootNavigationController *rootNavigationController;

@property (nonatomic, strong) SideMenuViewController* sideMenuViewController;
@property (nonatomic, strong) SideMenuModel* sideMenuModel;

-(instancetype) initAndAssemble;

@end
