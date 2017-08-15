//
//  EpicImageryView.m
//  briznichenkoProject
//
//  Created by briznichenko on 8/15/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "EpicImageryView.h"

@implementation EpicImageryView

- (instancetype) initAndInstallIntoSuperView:(UIView *) superview
{
    self = [super init];
    if(self)
    {
        [self makeView];
        [self makeInnerConstraints];
        [self makeOuterConstraints: superview];
    }
    return self;
}

- (void) makeView
{
    self.backgroundColor = [UIColor whiteColor];
    self.scrollEnabled = YES;
    self.userInteractionEnabled = YES;
    self.pagingEnabled = YES;
    [self makeSubviews];
}

-(void) makeSubviews
{
    NSMutableArray *imagesArray = [NSMutableArray new];
    for(int i = 0; i < 5; i++)
    {
        UIImageView *tempImageView = [UIImageView new];
        tempImageView.backgroundColor = [UIColor colorWithWhite:1.0 / i alpha:1.0f];
        [imagesArray addObject: tempImageView];
    }
    for(UIView *subview in imagesArray)
        [self addSubview:subview];
    self.imageryArray = [NSMutableArray arrayWithArray:imagesArray];
}

- (void) makeInnerConstraints
{
    for(int i = 0; i < self.subviews.count; i++)
    {
        self.subviews[i].translatesAutoresizingMaskIntoConstraints = NO;
        if(i == 0)
            [NSLayoutConstraint activateConstraints:
             @[[self.subviews[i].topAnchor constraintEqualToAnchor:self.topAnchor],
               [self.subviews[i].leftAnchor constraintEqualToAnchor:self.leftAnchor],
               [self.subviews[i].widthAnchor constraintEqualToAnchor:self.widthAnchor],
               [self.subviews[i].heightAnchor constraintEqualToAnchor:self.heightAnchor]]];
        else
            [NSLayoutConstraint activateConstraints:
             @[[self.subviews[i].topAnchor constraintEqualToAnchor:self.topAnchor],
               [self.subviews[i].leftAnchor constraintEqualToAnchor:self.subviews[i - 1].rightAnchor],
               [self.subviews[i].widthAnchor constraintEqualToAnchor:self.widthAnchor],
               [self.subviews[i].heightAnchor constraintEqualToAnchor:self.heightAnchor]]];
    }
}

- (void) makeOuterConstraints:(UIView *) superview
{
    [superview addSubview:self];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:
     @[[self.centerXAnchor constraintEqualToAnchor:superview.centerXAnchor],
       [self.centerYAnchor constraintEqualToAnchor:superview.centerYAnchor],
       [self.widthAnchor constraintEqualToAnchor:superview.widthAnchor],
       [self.heightAnchor constraintEqualToAnchor:superview.heightAnchor]
       ]];
}

@end
