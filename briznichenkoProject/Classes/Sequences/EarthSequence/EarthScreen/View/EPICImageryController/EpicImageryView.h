//
//  EpicImageryView.h
//  briznichenkoProject
//
//  Created by briznichenko on 8/15/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EpicImageryView : UIScrollView

@property (nonatomic, strong) NSArray *imageryArray;

- (instancetype) initAndInstallIntoSuperView:(UIView *) superview;

@end
