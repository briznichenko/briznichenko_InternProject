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
    [self makeObjectNameLabel];
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

- (void) makeObjectNameLabel
{
    self.objectNameLabel = [UILabel new];
    self.objectNameLabel.text = @"[PLACEHOLDER TEXT]";
    
    [self addSubview:self.objectNameLabel];
}

- (void) makeObjectInfoView
{
    self.objectInfoView = [UITextView new];
    self.objectInfoView.backgroundColor = [UIColor grayColor];
    
    [self addSubview:self.objectInfoView];
}

- (void) makeButtons
{
    self.galleryButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.galleryButton.backgroundColor = [UIColor orangeColor];
    [self addSubview:self.galleryButton];
    
    self.shareButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.shareButton.backgroundColor = [UIColor greenColor];
    [self addSubview:self.shareButton];
    
    self.saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.saveButton.backgroundColor = [UIColor cyanColor];
    [self addSubview:self.saveButton];
}

- (void) makeInnerConstraints
{
    self.objectImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.objectNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.objectInfoView.translatesAutoresizingMaskIntoConstraints = NO;
    self.galleryButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.shareButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.saveButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:
     @[[self.objectImageView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
       [self.objectImageView.topAnchor constraintEqualToAnchor:self.topAnchor],
       [self.objectImageView.widthAnchor constraintEqualToAnchor:self.widthAnchor],
       [self.objectImageView.heightAnchor constraintEqualToAnchor:self.heightAnchor multiplier:0.5f],
       
       [self.objectNameLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
       [self.objectNameLabel.topAnchor constraintEqualToAnchor:self.objectImageView.bottomAnchor],
       [self.objectNameLabel.widthAnchor constraintEqualToAnchor:self.widthAnchor],
       
       [self.objectInfoView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
       [self.objectInfoView.topAnchor constraintEqualToAnchor:self.objectNameLabel.bottomAnchor],
       [self.objectInfoView.widthAnchor constraintEqualToAnchor:self.widthAnchor],
       [self.objectInfoView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
       
       [self.galleryButton.topAnchor constraintEqualToAnchor:self.topAnchor],
       [self.galleryButton.rightAnchor constraintEqualToAnchor:self.rightAnchor],

       [self.shareButton.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
       [self.shareButton.leftAnchor constraintEqualToAnchor:self.leftAnchor],
       
       [self.saveButton.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
       [self.saveButton.rightAnchor constraintEqualToAnchor:self.rightAnchor]
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
