//
//  EPICImageryViewController.h
//  briznichenkoProject
//
//  Created by briznichenko on 8/15/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EpicImageryView.h"

@interface EPICImageryViewController : UIViewController
<UIScrollViewDelegate>

@property (nonatomic, strong) EpicImageryView *imageryView;

@end
