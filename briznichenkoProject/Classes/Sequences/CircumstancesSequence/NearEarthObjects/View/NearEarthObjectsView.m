//
//  NearEarthObjectsView.m
//  briznichenkoProject
//
//  Created by briznichenko on 23/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "NearEarthObjectsView.h"


@implementation NearEarthObjectsView


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
    [self makeTableView];
    [self makeDatePicking];
}

- (void) makeTableView
{
    self.objectsTable = [UITableView new];
    [self addSubview:self.objectsTable];
}

- (void) makeDatePicking
{
    self.startDateLabel = [UILabel new];
    self.startDateLabel.text = @"Objects for pediod:";
    [self addSubview:self.startDateLabel];
    
    self.endDateLabel = [UILabel new];
    self.endDateLabel.text = @"to";
    [self addSubview:self.endDateLabel];
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM-dd";
    
    self.startDateChanger = [UIButton buttonWithType:UIButtonTypeCustom];
    self.startDateChanger.backgroundColor = [UIColor colorWithWhite:0.05f alpha:1.0f];
    [self.startDateChanger setTitle:[formatter stringFromDate:[NSDate new]] forState:UIControlStateNormal];
    [self addSubview:self.startDateChanger];

    self.endDateChanger = [UIButton buttonWithType:UIButtonTypeCustom];
    self.endDateChanger.backgroundColor = [UIColor colorWithWhite:0.05f alpha:1.0f];
    [self.endDateChanger setTitle:[formatter stringFromDate:[NSDate new]] forState:UIControlStateNormal];
    [self addSubview:self.endDateChanger];
}

- (void) makeInnerConstraints
{
    self.startDateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.startDateChanger.translatesAutoresizingMaskIntoConstraints = NO;
    self.endDateChanger.translatesAutoresizingMaskIntoConstraints = NO;
    self.endDateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.objectsTable.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:
     @[[self.startDateLabel.topAnchor constraintEqualToAnchor:self.topAnchor],
       [self.startDateLabel.leftAnchor constraintEqualToAnchor:self.leftAnchor],
       
       [self.startDateChanger.topAnchor constraintEqualToAnchor:self.topAnchor],
       [self.startDateChanger.leftAnchor constraintEqualToAnchor:self.startDateLabel.rightAnchor],
       
       [self.endDateChanger.topAnchor constraintEqualToAnchor:self.topAnchor],
       [self.endDateChanger.rightAnchor constraintEqualToAnchor:self.rightAnchor],
       
       [self.endDateLabel.topAnchor constraintEqualToAnchor:self.topAnchor],
       [self.endDateLabel.rightAnchor constraintEqualToAnchor:self.endDateChanger.leftAnchor],
       
       [self.objectsTable.topAnchor constraintEqualToAnchor:self.startDateLabel.bottomAnchor],
       [self.objectsTable.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
       [self.objectsTable.widthAnchor constraintEqualToAnchor:self.widthAnchor],
       [self.objectsTable.bottomAnchor constraintEqualToAnchor:self.bottomAnchor]
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
