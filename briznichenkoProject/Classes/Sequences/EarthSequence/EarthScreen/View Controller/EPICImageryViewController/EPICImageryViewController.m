//
//  EPICImageryViewController.m
//  briznichenkoProject
//
//  Created by briznichenko on 8/16/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "EPICImageryViewController.h"

@implementation EPICImageryViewController
{
    UIActivityIndicatorView *activityIndicator;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewController];
}

- (void)setupViewController
{
    activityIndicator = [UIActivityIndicatorView new];
    [self.view addSubview:activityIndicator];
    activityIndicator.center = self.view.center;
    [self shouldHideActivityIndicator:NO];
    self.epicImageryScrollView.delegate = self;
}


#pragma mark -- Actions

- (void) updateImagery
{
    if(self.epicImageryScrollView.subviews.count == 0)
    {
        [self setupScrollViewWithImage:[self imageFromData:self.imageryArray[0]]];
        [self addFront:YES image:[self imageFromData:self.imageryArray[1]]];
        [self addFront:YES image:[self imageFromData:self.imageryArray[2]]];
        [self.imageryArray removeAllObjects];
        [self shouldHideActivityIndicator:YES];
    }
    
    [self.epicImageryScrollView setNeedsDisplay];
}

-(void) setupScrollViewWithImage:(UIImage*) initialImage
{
    UIImageView *EPICImageView = [[UIImageView alloc] initWithImage:initialImage];
    EPICImageView.contentMode = UIViewContentModeScaleToFill;
    EPICImageView.frame = self.epicImageryScrollView.frame;
    [self.epicImageryScrollView addSubview:EPICImageView];
    EPICImageView.backgroundColor = [UIColor greenColor];
    self.epicImageryScrollView.contentSize = self.epicImageryScrollView.frame.size;
}

- (void) addFront:(BOOL) front image:(UIImage *)image
{
    float EPICImageFrameOriginX = front ? self.epicImageryScrollView.subviews.lastObject.frame.origin.x + self.epicImageryScrollView.frame.size.width : self.epicImageryScrollView.subviews.firstObject.frame.origin.x - self.epicImageryScrollView.frame.size.width;
    UIImageView *EPICImageView = [[UIImageView alloc] initWithImage:image];
    EPICImageView.backgroundColor = [UIColor colorWithWhite:1.0f / self.epicImageryScrollView.subviews.count alpha:1.0f];
    EPICImageView.contentMode = UIViewContentModeScaleToFill;
    EPICImageView.frame = CGRectMake(EPICImageFrameOriginX,
                                     self.epicImageryScrollView.frame.origin.y,
                                     self.epicImageryScrollView.frame.size.width,
                                     self.epicImageryScrollView.frame.size.height);
    [self.epicImageryScrollView addSubview:EPICImageView];
    self.epicImageryScrollView.contentSize = CGSizeMake(self.epicImageryScrollView.contentSize.width + EPICImageView.frame.size.width,
                                                        self.epicImageryScrollView.frame.size.height);
}

- (void)shouldHideActivityIndicator:(BOOL) hideIndicator
{
    hideIndicator? [activityIndicator stopAnimating] : [activityIndicator startAnimating];
    activityIndicator.hidden = hideIndicator;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.epicImageryScrollView.subviews.firstObject removeFromSuperview];
    if(self.imageryArray.count != 0)
    {
        [self addFront:YES image:[self imageFromData:self.imageryArray[0]]];
//        [self.imageryArray removeObjectAtIndex:0];
    }
    else
    {
        
    }
}

#pragma mark - Util

- (UIImage *) imageFromData: (NSData *) data
{
    return [UIImage imageWithData:data];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
