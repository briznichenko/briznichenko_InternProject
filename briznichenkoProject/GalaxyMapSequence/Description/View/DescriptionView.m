//
//  DescriptionView.m
//  briznichenkoProject
//
//  Created by briznichenko on 31/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "DescriptionView.h"


@implementation DescriptionView


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
    [self makeObjectImageView];
    [self makeObjectInfoView];
    [self makeButtons];
}

- (void) makeObjectImageView
{
    self.objectImageView = [[UIImageView alloc] init];
    self.objectImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.objectImageView.backgroundColor = [UIColor blueColor];
    
    [self addSubview: self.objectImageView];
}

- (void) makeObjectInfoView
{
    self.objectInfoView = [UITextView new];
    self.objectInfoView.backgroundColor = [UIColor grayColor];
    
    [self addSubview:self.objectInfoView];
}

- (void) makeButtons
{
    
}

- (void) makeInnerConstraints
{
    self.objectImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.objectInfoView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:
     @[[self.objectImageView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
       [self.objectImageView.topAnchor constraintEqualToAnchor:self.topAnchor],
       [self.objectImageView.widthAnchor constraintEqualToAnchor:self.widthAnchor],
       [self.objectImageView.heightAnchor constraintEqualToAnchor:self.heightAnchor multiplier:0.5f],
       
       [self.objectInfoView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
       [self.objectInfoView.topAnchor constraintEqualToAnchor:self.objectImageView.bottomAnchor],
       [self.objectInfoView.widthAnchor constraintEqualToAnchor:self.widthAnchor],
       [self.objectInfoView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor]
       ]];
}

- (void) makeOuterConstraints:(UIView *) superview
{
	[superview addSubview:self];
    
    float viewSizeMultiplier = 0.85f;
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:
     @[[self.centerXAnchor constraintEqualToAnchor:superview.centerXAnchor],
       [self.centerYAnchor constraintEqualToAnchor:superview.centerYAnchor],
       [self.widthAnchor constraintEqualToAnchor:superview.widthAnchor multiplier:viewSizeMultiplier],
       [self.heightAnchor constraintEqualToAnchor:superview.heightAnchor multiplier:viewSizeMultiplier]
     ]];

}

@end
