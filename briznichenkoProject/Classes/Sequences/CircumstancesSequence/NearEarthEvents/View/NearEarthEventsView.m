//
//  NearEarthEventsView.m
//  briznichenkoProject
//
//  Created by briznichenko on 23/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "NearEarthEventsView.h"


@implementation NearEarthEventsView


- (instancetype) initAndInstallIntoSuperView:(UIView *) superview topY:(float) topY
{
	self = [super init];
	if(self)
	{
		[self makeView];
		[self makeInnerConstraints];
		[self makeOuterConstraints: superview topY:topY];
	}
	return self;
}

- (void) makeView
{
    [self makeEventsWebView];
}

- (void) makeEventsWebView
{
    self.eventsWebView = [UIWebView new];
    [self addSubview:self.eventsWebView];
}

- (void) makeInnerConstraints
{
    self.eventsWebView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:
     @[[self.eventsWebView.centerXAnchor constraintEqualToAnchor: self.centerXAnchor],
       [self.eventsWebView.topAnchor constraintEqualToAnchor: self.topAnchor],
       [self.eventsWebView.widthAnchor constraintEqualToAnchor: self.widthAnchor],
       [self.eventsWebView.heightAnchor constraintEqualToAnchor: self.heightAnchor]
       ]];
}

- (void) makeOuterConstraints:(UIView *) superview topY:(float) topY
{
    [superview addSubview:self];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:
     @[[self.centerXAnchor constraintEqualToAnchor:superview.centerXAnchor],
       [self.topAnchor constraintGreaterThanOrEqualToAnchor:superview.topAnchor constant:topY],
       [self.widthAnchor constraintEqualToAnchor:superview.widthAnchor],
       [self.heightAnchor constraintEqualToAnchor:superview.heightAnchor multiplier: (superview.frame.size.height - topY) / superview.frame.size.height]
       ]];
}

@end
