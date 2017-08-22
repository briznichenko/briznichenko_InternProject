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
    [self makeMenuButton];
}

- (void) makeHeaderImage
{
    float borderWidth = 2.0f;
    
    self.headerImage = [UIImageView new];
    self.headerImage.layer.borderWidth = borderWidth;
    self.headerImage.layer.borderColor = [UIColor whiteColor].CGColor;
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

- (void) makeMenuButton
{
    self.menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.menuButton.backgroundColor = [UIColor whiteColor];
    [self.menuButton setTitle:@"MENU" forState:UIControlStateNormal];
    [self.menuButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:self.menuButton];
}

- (void) makeInnerConstraints
{
    float imageHeightMultiplier = 0.35f;
    float menuHeightMultiplier = 1.0f - imageHeightMultiplier;
    
    self.headerImage.translatesAutoresizingMaskIntoConstraints = NO;
    self.menuItems.translatesAutoresizingMaskIntoConstraints = NO;
    self.appNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.menuButton.translatesAutoresizingMaskIntoConstraints = NO;
    
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
        [self.menuItems.heightAnchor constraintEqualToAnchor:self.heightAnchor multiplier: menuHeightMultiplier],
        
        [self.menuButton.leftAnchor constraintEqualToAnchor:self.rightAnchor],
        [self.menuItems.topAnchor constraintGreaterThanOrEqualToAnchor:self.topAnchor constant:-30.0f],
        [self.menuItems.widthAnchor constraintEqualToConstant:60.0f],
        [self.menuItems.heightAnchor constraintEqualToConstant:40.0f]
       ]];
}

- (void) makeOuterConstraints:(UIView *) superview
{
	[superview addSubview:self];
    float widthMultiplier = 0.6f;
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:
     @[[self.topAnchor constraintEqualToAnchor:superview.topAnchor ],
       [self.leftAnchor constraintEqualToAnchor:superview.leftAnchor],
       [self.widthAnchor constraintEqualToAnchor:superview.widthAnchor multiplier: widthMultiplier],
       [self.heightAnchor constraintEqualToAnchor:superview.heightAnchor]
     ]];
}
@end
