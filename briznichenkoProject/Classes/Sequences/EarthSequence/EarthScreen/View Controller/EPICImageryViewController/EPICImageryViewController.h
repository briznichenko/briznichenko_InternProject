//
//  EPICImageryViewController.h
//  briznichenkoProject
//
//  Created by briznichenko on 8/16/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EPICImageryViewController : UIViewController
<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *imageryArray;

@property (strong, nonatomic) IBOutlet UIScrollView *epicImageryScrollView;

- (void)populateWithImages;

@end
