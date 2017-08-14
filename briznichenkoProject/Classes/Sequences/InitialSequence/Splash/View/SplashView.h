//
//  SplashView.h
//  briznichenkoProject
//
//  Created by briznichenko on 17/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SplashView : UIView

@property(nonatomic, strong) UIImageView *splashImageView;
@property(nonatomic, strong) UILabel *splashLabel;

-(instancetype)initAndInstallIntoSuperView:(UIView *) superview;

@end
