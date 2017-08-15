//
//  EarthScreenView.m
//  briznichenkoProject
//
//  Created by briznichenko on 04/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "EarthScreenView.h"


@implementation EarthScreenView

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
    [self makeHeader];
    [self makeContainerView];
}

- (void) makeHeader
{
    self.headerView = [UIView new];
    [self addSubview:self.headerView];
    
    self.dateLabel = [UILabel new];
    self.dateLabel.text = [NSString stringWithFormat:@"%@", [NSDate new]];
    self.dateLabel.backgroundColor = [UIColor blueColor];
    self.dateLabel.textColor = [UIColor whiteColor];
    [self.headerView addSubview:self.dateLabel];
    
    self.getEventsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.getEventsButton.backgroundColor = [UIColor blueColor];
    [self.getEventsButton setTitle:@"Events >" forState:UIControlStateNormal];
    [self.getEventsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.headerView addSubview:self.getEventsButton];
    
    self.viewSwitcher = [UISegmentedControl new];
    [self.headerView addSubview:self.viewSwitcher];
}

- (void) makeContainerView
{
    self.containerView = [UIView new];
    self.containerView.backgroundColor = [UIColor darkGrayColor];
    self.containerView.userInteractionEnabled = YES;
    [self addSubview:self.containerView];
}

- (void) makeInnerConstraints
{
    float headerHeightMultiplier = 0.3f;
    
    float dateLabelHeightMultiplier = 0.3f;
    float dateLabelWidthMultiplier = 0.6f;
    float dateLabelTopSpacing = 40.0f;
    
    float viewSwitcherHeightMultiplier = 0.5f;
    float viewSwitcherTopSpacing = 20.0f;
        
    self.getEventsButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.containerView.translatesAutoresizingMaskIntoConstraints = NO;
    self.viewSwitcher.translatesAutoresizingMaskIntoConstraints = NO;
    self.headerView.translatesAutoresizingMaskIntoConstraints = NO;
    self.dateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:
     @[[self.headerView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
       [self.headerView.topAnchor constraintEqualToAnchor:self.topAnchor],
       [self.headerView.widthAnchor constraintEqualToAnchor:self.widthAnchor],
       [self.headerView.heightAnchor constraintEqualToAnchor:self.heightAnchor multiplier:headerHeightMultiplier],
       
       [self.dateLabel.leftAnchor constraintEqualToAnchor:self.leftAnchor],
       [self.dateLabel.topAnchor constraintEqualToAnchor:self.headerView.topAnchor constant:dateLabelTopSpacing],
       [self.dateLabel.widthAnchor constraintEqualToAnchor:self.widthAnchor multiplier:dateLabelWidthMultiplier],
       [self.dateLabel.heightAnchor constraintEqualToAnchor:self.headerView.heightAnchor multiplier:dateLabelHeightMultiplier],
       
       [self.getEventsButton.leftAnchor constraintEqualToAnchor:self.dateLabel.rightAnchor],
       [self.getEventsButton.topAnchor constraintEqualToAnchor:self.headerView.topAnchor constant:dateLabelTopSpacing],
       [self.getEventsButton.rightAnchor constraintEqualToAnchor:self.headerView.rightAnchor],
       [self.getEventsButton.heightAnchor constraintEqualToAnchor:self.headerView.heightAnchor multiplier:dateLabelHeightMultiplier],
       
       [self.viewSwitcher.centerXAnchor constraintEqualToAnchor:self.headerView.centerXAnchor],
       [self.viewSwitcher.topAnchor constraintEqualToAnchor:self.dateLabel.bottomAnchor constant:viewSwitcherTopSpacing],
       [self.viewSwitcher.widthAnchor constraintEqualToAnchor:self.headerView.widthAnchor],
       [self.viewSwitcher.heightAnchor constraintEqualToAnchor:self.headerView.heightAnchor multiplier:viewSwitcherHeightMultiplier],
       
       [self.containerView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
       [self.containerView.topAnchor constraintEqualToAnchor:self.headerView.bottomAnchor],
       [self.containerView.widthAnchor constraintEqualToAnchor:self.widthAnchor],
       [self.containerView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor]
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
