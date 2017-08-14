//
//  SideMenuView.m
//  briznichenkoProject
//
//  Created by briznichenko on 25/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "SideMenuView.h"


@implementation SideMenuView

- (instancetype) initAndInstallIntoSuperView:(UIView *) superview
{
	self = [super init];
	if(self)
	{
		[self makeView];
        [self makeOuterConstraints: superview];
		[self makeInnerConstraints];
	}
	return self;
}

- (void) makeView
{
    self.backgroundColor = [UIColor whiteColor];
    
    [self makeHeaderImage];
    [self makeMenuEntries];
    [self makeAppNameLabel];
}

- (void) makeHeaderImage
{
    float borderWidth = 2.0f;
    CGColorRef borderColor = [UIColor colorWithRed:0.0f green:0.07450980392f blue:0.2f alpha:1.0f].CGColor;
    
    self.headerImage = [UIImageView new];
    self.headerImage.layer.borderWidth = borderWidth;
    self.headerImage.layer.borderColor = borderColor;
    self.headerImage.backgroundColor = [UIColor blackColor];
//    self.headerImage.clipsToBounds = YES;
    self.headerImage.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview: self.headerImage];
}

- (void) makeMenuEntries
{
    self.menuItems = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
    self.menuItems.scrollEnabled = NO;
    [self addSubview: self.menuItems];
}

- (void) makeAppNameLabel
{
    self.appNameLabel = [UILabel new];
    self.appNameLabel.text = @"APPLICATION NAME";
    [self.headerImage addSubview:self.appNameLabel];
}

- (void) makeInnerConstraints
{
    float imageHeightMultiplier = 0.35f;
    float menuHeightMultiplier = 1.0f - imageHeightMultiplier;
    
    self.headerImage.translatesAutoresizingMaskIntoConstraints = NO;
    self.menuItems.translatesAutoresizingMaskIntoConstraints = NO;
    self.appNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:
     @[ [self.headerImage.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
     	[self.headerImage.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.headerImage.heightAnchor constraintEqualToAnchor:self.heightAnchor multiplier: imageHeightMultiplier],
        [self.headerImage.widthAnchor constraintEqualToAnchor:self.headerImage.heightAnchor],
        
        [self.appNameLabel.centerXAnchor constraintEqualToAnchor:self.headerImage.centerXAnchor],
        [self.appNameLabel.centerYAnchor constraintEqualToAnchor:self.headerImage.centerYAnchor],
        
        [self.menuItems.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
        [self.menuItems.topAnchor constraintEqualToAnchor:self.headerImage.bottomAnchor],
        [self.menuItems.widthAnchor constraintEqualToAnchor:self.widthAnchor],
        [self.menuItems.heightAnchor constraintEqualToAnchor:self.heightAnchor multiplier: menuHeightMultiplier]
       ]];
}

- (void) makeOuterConstraints:(UIView *) superview
{
	[superview addSubview:self];
    float widthMultiplier = 0.6f;
//    float statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:
     @[[self.topAnchor constraintEqualToAnchor:superview.topAnchor ],
       [self.leftAnchor constraintEqualToAnchor:superview.leftAnchor],
       [self.widthAnchor constraintEqualToAnchor:superview.widthAnchor multiplier: widthMultiplier],
       [self.heightAnchor constraintEqualToAnchor:superview.heightAnchor]
     ]];
}
@end
