//
//  SideMenuViewController.h
//  briznichenkoProject
//
//  Created by briznichenko on 25/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SideMenuProtocols.h"
#import "SideMenuView.h"

@interface SideMenuViewController : UIViewController
<SideMenuViewControllerProtocol, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) SideMenuView* sidemenuView;
@property (nonatomic, strong) NSArray *menuEntries;

@end
