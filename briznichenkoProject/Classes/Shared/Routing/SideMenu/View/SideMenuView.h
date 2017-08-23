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
@property (nonatomic, strong) UIImageView *roundImage;
@property (nonatomic, strong) UITableView *menuItems;
@property (nonatomic, strong) UILabel *appNameLabel;
@property (nonatomic, strong) UIButton *menuButton;

-(instancetype)initAndInstallIntoSuperView:(UIView *) superview;

@end
