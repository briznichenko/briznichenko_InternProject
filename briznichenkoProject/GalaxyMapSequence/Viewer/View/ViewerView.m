//
//  ViewerView.m
//  briznichenkoProject
//
//  Created by briznichenko on 01/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "ViewerView.h"


@implementation ViewerView


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
    [self makeViewedImageView];
    [self makeBottomBar];
}

- (void) makeViewedImageView
{
    self.viewedImageView = [UIImageView new];
    //
    self.viewedImageView.backgroundColor = [UIColor orangeColor];
    
    [self addSubview:self.viewedImageView];
}

- (void) makeBottomBar
{
    self.stubBar = [UIView new];
    self.stubBar.backgroundColor = [UIColor blueColor];
    
    [self addSubview:self.stubBar];
}

- (void) makeInnerConstraints
{
    float imageViewHeightMultiplier = 0.75f;
    
    self.viewedImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.stubBar.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:
     @[[self.viewedImageView.topAnchor constraintEqualToAnchor:self.topAnchor],
       [self.viewedImageView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
       [self.viewedImageView.widthAnchor constraintEqualToAnchor:self.widthAnchor],
       [self.viewedImageView.heightAnchor constraintEqualToAnchor:self.heightAnchor multiplier:imageViewHeightMultiplier],
       
       [self.stubBar.topAnchor constraintEqualToAnchor:self.viewedImageView.bottomAnchor],
       [self.stubBar.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
       [self.stubBar.widthAnchor constraintEqualToAnchor:self.widthAnchor],
       [self.stubBar.bottomAnchor constraintEqualToAnchor:self.bottomAnchor]]];
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
