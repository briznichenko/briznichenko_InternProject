//
//  SharingView.h
//  briznichenkoProject
//
//  Created by briznichenko on 09/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SharingView : UIView 

@property (nonatomic, strong) UIView *facebookPlaceholderView;
@property (nonatomic, strong) UIView *twitterPlaceholderView;
@property (nonatomic, strong) UIView *googlePlaceholderView;

-(instancetype)initAndInstallIntoSuperView:(UIView *) superview;

@end
