//
//  SideMenuView.m
//  briznichenkoProject
//
//  Created by briznichenko on 25/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "SideMenuView.h"


@implementation SideMenuView
{
    UIView *statusBarView;
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
    self.backgroundColor = [UIColor whiteColor];
    
    statusBarView = [UIView new];
    [self addSubview:statusBarView];
    
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
    self.headerImage.clipsToBounds = YES;
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
    self.headerImage.translatesAutoresizingMaskIntoConstraints = NO;
    self.menuItems.translatesAutoresizingMaskIntoConstraints = NO;
    self.appNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    statusBarView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:
     @[ [statusBarView.topAnchor constraintEqualToAnchor: self.topAnchor],
        [statusBarView.widthAnchor constraintEqualToAnchor:self.widthAnchor],
        [statusBarView.leftAnchor constraintEqualToAnchor:self.leftAnchor],
        [statusBarView.heightAnchor constraintEqualToConstant:20.0f],
        
        [self.headerImage.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
     	[self.headerImage.topAnchor constraintEqualToAnchor:statusBarView.bottomAnchor],
        [self.headerImage.widthAnchor constraintEqualToAnchor:self.widthAnchor],
        [self.headerImage.heightAnchor constraintEqualToAnchor:self.headerImage.widthAnchor],
        
        [self.appNameLabel.centerXAnchor constraintEqualToAnchor:self.headerImage.centerXAnchor],
        [self.appNameLabel.centerYAnchor constraintEqualToAnchor:self.headerImage.centerYAnchor],
        
        [self.menuItems.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
        [self.menuItems.topAnchor constraintEqualToAnchor:self.headerImage.bottomAnchor],
        [self.menuItems.widthAnchor constraintEqualToAnchor:self.widthAnchor],
        [self.menuItems.bottomAnchor constraintEqualToAnchor:self.bottomAnchor]
       ]];
}

- (void) makeOuterConstraints:(UIView *) superview
{
	[superview addSubview:self];
    float widthMultiplier = 0.6f;
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:
     @[[self.leftAnchor constraintEqualToAnchor:superview.leftAnchor],
       [self.topAnchor constraintGreaterThanOrEqualToAnchor:superview.topAnchor],
       [self.widthAnchor constraintEqualToAnchor:superview.widthAnchor multiplier: widthMultiplier],
       [self.heightAnchor constraintLessThanOrEqualToAnchor:superview.heightAnchor]
     ]];

}

@end
