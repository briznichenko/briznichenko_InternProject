//
//  MapView.h
//  briznichenkoProject
//
//  Created by briznichenko on 18/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapView : UIView 

@property (nonatomic, strong) UIWebView *map;

-(instancetype)initAndInstallIntoSuperView:(UIView *) superview;

@end
