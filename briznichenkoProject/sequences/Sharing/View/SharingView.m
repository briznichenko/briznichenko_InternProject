//
//  SharingView.m
//  briznichenkoProject
//
//  Created by briznichenko on 09/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "SharingView.h"


@implementation SharingView


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
    [self makePlaceholderViews];
}

- (void) makePlaceholderViews
{
    self.facebookPlaceholderView = [UIView new];
    self.twitterPlaceholderView = [UIView new];
    self.googlePlaceholderView = [UIView new];
    
    [self addSubview:self.facebookPlaceholderView];
    [self addSubview:self.twitterPlaceholderView];
    [self addSubview:self.googlePlaceholderView];
}

- (void) makeInnerConstraints
{
    float superviewWidthMultiplier = 1.0f / 3.0f;
    
    self.facebookPlaceholderView.translatesAutoresizingMaskIntoConstraints = NO;
    self.twitterPlaceholderView.translatesAutoresizingMaskIntoConstraints = NO;
    self.googlePlaceholderView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:
     @[[self.facebookPlaceholderView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
       [self.facebookPlaceholderView.leftAnchor constraintEqualToAnchor:self.leftAnchor],
       [self.facebookPlaceholderView.heightAnchor constraintEqualToAnchor:self.heightAnchor],
       [self.facebookPlaceholderView.widthAnchor constraintEqualToAnchor:self.widthAnchor multiplier:superviewWidthMultiplier],
       
       [self.twitterPlaceholderView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
       [self.twitterPlaceholderView.leftAnchor constraintEqualToAnchor:self.self.facebookPlaceholderView.rightAnchor],
       [self.twitterPlaceholderView.heightAnchor constraintEqualToAnchor:self.heightAnchor],
       [self.twitterPlaceholderView.widthAnchor constraintEqualToAnchor:self.widthAnchor multiplier:superviewWidthMultiplier],
       
       [self.googlePlaceholderView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
       [self.googlePlaceholderView.leftAnchor constraintEqualToAnchor:self.twitterPlaceholderView.rightAnchor],
       [self.googlePlaceholderView.heightAnchor constraintEqualToAnchor:self.heightAnchor],
       [self.googlePlaceholderView.widthAnchor constraintEqualToAnchor:self.widthAnchor multiplier:superviewWidthMultiplier]]];
}

- (void) makeOuterConstraints:(UIView *) superview
{
	[superview addSubview:self];
    float widthMultiplier = 0.95f;
    float heightMultiplier = 0.2f;
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:
     @[[self.centerXAnchor constraintEqualToAnchor:superview.centerXAnchor],
       [self.centerYAnchor constraintEqualToAnchor:superview.centerYAnchor],
       [self.widthAnchor constraintEqualToAnchor:superview.widthAnchor multiplier: widthMultiplier],
       [self.heightAnchor constraintEqualToAnchor:superview.heightAnchor multiplier: heightMultiplier]
     ]];

}

@end
