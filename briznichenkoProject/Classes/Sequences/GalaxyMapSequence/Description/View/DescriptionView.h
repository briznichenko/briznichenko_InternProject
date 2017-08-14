//
//  DescriptionView.h
//  briznichenkoProject
//
//  Created by briznichenko on 31/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DescriptionView : UIView

@property (nonatomic, strong) UIImageView *objectImageView;
@property (nonatomic, strong) UILabel *objectNameLabel;
@property (nonatomic, strong) UITextView *objectInfoView;

@property (nonatomic, strong) UIButton *galleryButton;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UIButton *saveButton;

-(instancetype)initAndInstallIntoSuperView:(UIView *) superview;

@end
