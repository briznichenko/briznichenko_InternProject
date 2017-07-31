//
//  PopupView.h
//  briznichenkoProject
//
//  Created by briznichenko on 7/27/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopupView : UIView

@property (nonatomic, strong) UILabel *celestialBodyNameLabel;
@property (nonatomic, strong) UILabel *celestialBodyRaDecLabel;
@property (nonatomic, strong) UIButton *descriptionButton;
@property (nonatomic, strong) UIButton *galleryButton;

-(instancetype)initAndInstallIntoSuperView:(UIView *) superview;

@end
