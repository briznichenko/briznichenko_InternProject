//
//  MapView.m
//  briznichenkoProject
//
//  Created by briznichenko on 18/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "MapView.h"


@implementation MapView
{
    UIColor *mainColor;
}

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
    mainColor = [UIColor colorWithRed:0.0f green:0.07450980392f blue:0.2f alpha:1.0f];
    self.backgroundColor = mainColor;
    [self makeMap];
}

- (void) makeMap
{
    self.map = [[UIWebView alloc] initWithFrame:self.frame];
    self.map.backgroundColor = mainColor;
    self.map.scrollView.bounces = NO;
    self.map.scrollView.scrollEnabled = NO;
    self.map.userInteractionEnabled = YES;
    
    [self addSubview:self.map];
}

- (void) makeInnerConstraints
{
    self.map.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:
     @[[self.map.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
       [self.map.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
       [self.map.widthAnchor constraintEqualToAnchor:self.widthAnchor],
       [self.map.heightAnchor constraintEqualToAnchor:self.heightAnchor]
       ]];
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
