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
		[self makeInnerConstraints];
		[self makeOuterConstraints: superview];
	}
	return self;
}

- (void) makeView
{
    self.backgroundColor = [UIColor whiteColor];
    [self makeEPICImage];
    [self makeMenuEntries];
    [self makeAppNameLabel];
}

- (void) makeEPICImage
{
    float borderWidth = 2.0f;
    CGColorRef borderColor = [UIColor colorWithRed:0.0f green:0.07450980392f blue:0.2f alpha:1.0f].CGColor;
    
    self.EPICImage = [UIImageView new];
    self.EPICImage.layer.borderWidth = borderWidth;
    self.EPICImage.layer.borderColor = borderColor;
    self.EPICImage.clipsToBounds = YES;
    self.EPICImage.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview: self.EPICImage];
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
    self.appNameLabel.text = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    [self.EPICImage addSubview:self.appNameLabel];
}

- (void) makeInnerConstraints
{
    float EPICImageHeightMultiplier = 0.4f;
    
    self.EPICImage.translatesAutoresizingMaskIntoConstraints = NO;
    self.menuItems.translatesAutoresizingMaskIntoConstraints = NO;
    self.appNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
		[NSLayoutConstraint activateConstraints:
     @[ [self.EPICImage.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
     	[self.EPICImage.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.EPICImage.widthAnchor constraintEqualToAnchor:self.widthAnchor],
        [self.EPICImage.heightAnchor constraintEqualToAnchor:self.heightAnchor multiplier:EPICImageHeightMultiplier],
        
        [self.appNameLabel.centerXAnchor constraintEqualToAnchor:self.EPICImage.centerXAnchor],
        [self.appNameLabel.centerYAnchor constraintEqualToAnchor:self.EPICImage.centerYAnchor],
        
        [self.menuItems.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
        [self.menuItems.topAnchor constraintEqualToAnchor:self.EPICImage.bottomAnchor],
        [self.menuItems.widthAnchor constraintEqualToAnchor:self.widthAnchor],
        [self.menuItems.heightAnchor constraintEqualToAnchor:self.heightAnchor multiplier:(1.0f - EPICImageHeightMultiplier)]
       ]];
}

- (void) makeOuterConstraints:(UIView *) superview
{
	[superview addSubview:self];
    float widthMultiplier = 0.6f;
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:
     @[[self.leftAnchor constraintEqualToAnchor:superview.leftAnchor],
       [self.centerYAnchor constraintEqualToAnchor:superview.centerYAnchor],
       [self.widthAnchor constraintEqualToAnchor:superview.widthAnchor multiplier: widthMultiplier],
       [self.heightAnchor constraintEqualToAnchor:superview.heightAnchor]
     ]];

}

@end
