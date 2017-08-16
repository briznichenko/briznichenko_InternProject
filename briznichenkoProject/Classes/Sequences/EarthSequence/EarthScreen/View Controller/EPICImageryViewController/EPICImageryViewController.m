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

//-(void)populateWithImages
//{
//    __block float contentWidth = 0.0f;
//    dispatch_async(dispatch_get_main_queue(), ^{
//        for (int i = 0; i < self.imageryArray.count; i++)
//        {
//            UIImage *epicImage = [UIImage imageWithData:self.imageryArray[i]];
//            UIImageView *epicImageView = [[UIImageView alloc] initWithImage:epicImage];
//            if(i == 0)
//                epicImageView.frame = self.epicImageryScrollView.frame;
//            else
//                epicImageView.frame = CGRectMake(self.epicImageryScrollView.subviews[i - 1].frame.origin.x + self.epicImageryScrollView.frame.size.width,
//                                                 self.epicImageryScrollView.frame.origin.y,
//                                                 self.epicImageryScrollView.frame.size.width,
//                                                 self.epicImageryScrollView.frame.size.height);
//            epicImageView.backgroundColor = [UIColor colorWithWhite:1.0f / i alpha:1.0f];
//            [self.epicImageryScrollView addSubview:epicImageView];
//            if(self.epicImageryScrollView.subviews.count == self.imageryArray.count)
//            {
//                self.epicImageryScrollView.contentSize = CGSizeMake(self.epicImageryScrollView.frame.size.height * self.epicImageryScrollView.subviews.count,
//                                                                    self.epicImageryScrollView.frame.size.height);
//                [self.epicImageryScrollView setNeedsDisplay];
//                [self shouldHideActivityIndicator:YES];
//            }
//        }
//    });
//}

- (void) updateImagery
{
    //if kokoko
    [self setupScrollViewWithImage:[self imageFromData:self.imageryArray[0]]];
    [self addNextImage:[self imageFromData:self.imageryArray[1]]];
    [self addNextImage:[self imageFromData:self.imageryArray[2]]];
    
    [self shouldHideActivityIndicator:YES];
    [self.epicImageryScrollView setNeedsDisplay];
}

-(void) setupScrollViewWithImage:(UIImage*) initialImage
{
    UIImageView *EPICImageView = [[UIImageView alloc] initWithImage:initialImage];
    EPICImageView.frame = self.epicImageryScrollView.frame;
    [self.epicImageryScrollView addSubview:EPICImageView];
}

- (void) addNextImage:(UIImage *)nextImage
{
    CGRect EPICImageViewFrame = CGRectMake(self.epicImageryScrollView.subviews.lastObject.frame.origin.x + self.epicImageryScrollView.frame.size.width,
                                            self.epicImageryScrollView.subviews.lastObject.frame.origin.y,
                                            self.epicImageryScrollView.frame.size.width,
                                            self.epicImageryScrollView.frame.size.height);
    UIImageView *EPICImageView = [[UIImageView alloc] initWithImage:nextImage];
    EPICImageView.frame = EPICImageViewFrame;
    [self.epicImageryScrollView addSubview:EPICImageView];
    self.epicImageryScrollView.contentSize = CGSizeMake(self.epicImageryScrollView.contentSize.width + EPICImageView.frame.size.width,
                                    self.epicImageryScrollView.contentSize.height);
}

- (void) addPreviousImage:(UIImage*) previousImage
{
    CGRect EPICImageViewFrame = CGRectMake(self.epicImageryScrollView.subviews.lastObject.frame.origin.x - self.epicImageryScrollView.frame.size.width,
                                           self.epicImageryScrollView.subviews.lastObject.frame.origin.y,
                                           self.epicImageryScrollView.frame.size.width,
                                           self.epicImageryScrollView.frame.size.height);
    UIImageView *EPICImageView = [[UIImageView alloc] initWithImage:previousImage];
    EPICImageView.frame = EPICImageViewFrame;
    [self.epicImageryScrollView addSubview:EPICImageView];
}

- (void)shouldHideActivityIndicator:(BOOL) hideIndicator
{
    hideIndicator? [activityIndicator stopAnimating] : [activityIndicator startAnimating];
    activityIndicator.hidden = hideIndicator;
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
