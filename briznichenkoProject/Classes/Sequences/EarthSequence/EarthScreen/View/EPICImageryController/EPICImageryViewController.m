//
//  EPICImageryViewController.m
//  briznichenkoProject
//
//  Created by briznichenko on 8/15/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "EPICImageryViewController.h"

@interface EPICImageryViewController ()

@end

@implementation EPICImageryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageryView = [[EpicImageryView alloc] initAndInstallIntoSuperView: self.view];
    self.imageryView.delegate = self;
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self calculateContentSize];
    
}

-(void) calculateContentSize
{
    float contentSize = 0;
    for(UIView *subview in self.imageryView.imageryArray)
        contentSize += subview.frame.size.width;
    self.imageryView.contentSize = CGSizeMake(contentSize, self.imageryView.frame.size.height);
    NSLog(@"%f, %f", self.imageryView.contentSize.height, self.imageryView.contentSize.width);
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    float contentSize = scrollView.contentSize.width / scrollView.subviews.count;
    int index = scrollView.contentOffset.x / contentSize;
    NSLog(@"%i", index);
    NSLog(@"%lu", scrollView.subviews.count);
    if(index == 2)
    {
        [scrollView addSubview: scrollView.subviews[index]];
        [scrollView.subviews[index] removeFromSuperview];
    }
}



@end
