//
//  EarthScreenView.h
//  briznichenkoProject
//
//  Created by briznichenko on 04/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EarthScreenView : UIView

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIButton *getEventsButton;
@property (nonatomic, strong) UISegmentedControl *viewSwitcher;
@property (nonatomic, strong) UIView *containerView;

-(instancetype)initAndInstallIntoSuperView:(UIView *) superview;

@end
