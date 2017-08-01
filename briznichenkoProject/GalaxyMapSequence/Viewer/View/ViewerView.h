//
//  ViewerView.h
//  briznichenkoProject
//
//  Created by briznichenko on 01/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewerView : UIView

@property (nonatomic, strong) UIImageView *viewedImageView;
@property (nonatomic, strong) UIView *stubBar;

-(instancetype)initAndInstallIntoSuperView:(UIView *) superview;

@end
