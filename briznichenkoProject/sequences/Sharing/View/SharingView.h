//
//  SharingView.h
//  briznichenkoProject
//
//  Created by briznichenko on 09/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SharingView : UIView 

@property (nonatomic, strong) UIButton *facebookButton;
@property (nonatomic, strong) UIButton *twitterButton;
@property (nonatomic, strong) UIButton *googlePlusButton;

-(instancetype)initAndInstallIntoSuperView:(UIView *) superview;

@end
