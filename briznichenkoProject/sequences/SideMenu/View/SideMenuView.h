//
//  SideMenuView.h
//  briznichenkoProject
//
//  Created by briznichenko on 25/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SideMenuView : UIView

@property (nonatomic, strong) UIImageView *headerImage;
@property (nonatomic, strong) UITableView *menuItems;
@property (nonatomic, strong) UILabel *appNameLabel;

-(instancetype)initAndInstallIntoSuperView:(UIView *) superview;

@end
