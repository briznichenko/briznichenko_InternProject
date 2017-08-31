//
//  ViewerView.h
//  briznichenkoProject
//
//  Created by briznichenko on 01/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CropView.h"

@interface ViewerView : UIView

@property (nonatomic, strong) UIImageView *viewedImageView;
@property (nonatomic, strong) UIButton* modeSwitcher;

@property (nonatomic, strong) UIView *bottomBar;

@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UIButton *saveButton;

@property (nonatomic, strong) UIButton *cutButton;
@property (nonatomic, strong) UIButton *filtersButton;
@property (nonatomic, strong) UIButton *textButton;

@property (nonatomic, strong) CropView *cropViewOverlay;
@property (nonatomic, strong) UIView *cropView;
@property (nonatomic, strong) UIScrollView *filterBar;
@property (nonatomic, strong) UITextField *addTextField;
@property (nonatomic, strong) UISlider *textSizeSlider;

-(instancetype)initAndInstallIntoSuperView:(UIView *) superview;

@end
