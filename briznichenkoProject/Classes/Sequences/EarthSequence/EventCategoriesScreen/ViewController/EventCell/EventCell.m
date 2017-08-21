//
//  EventCell.m
//  briznichenkoProject
//
//  Created by briznichenko on 8/21/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "EventCell.h"

@implementation EventCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self setupCell];
    }
    return self;
}

- (void)setupCell
{
    self.eventNameLabel = [UILabel new];
    self.eventNameLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.eventNameLabel];
    
    self.eventDescriptionView = [UITextView new];
    self.eventDescriptionView.editable = NO;
    [self addSubview:self.eventDescriptionView];
    
    [self makeConstraints];
}

- (void)makeConstraints
{
    self.eventNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.eventDescriptionView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:
     @[[self.eventNameLabel.topAnchor constraintEqualToAnchor: self.topAnchor],
       [self.eventNameLabel.centerXAnchor constraintEqualToAnchor: self.centerXAnchor],
       
       [self.eventDescriptionView.topAnchor constraintEqualToAnchor: self.eventNameLabel.bottomAnchor],// constant: topSpacing],
       [self.eventDescriptionView.centerXAnchor constraintEqualToAnchor: self.centerXAnchor],
       [self.eventDescriptionView.widthAnchor constraintEqualToAnchor: self.widthAnchor],
       [self.eventDescriptionView.bottomAnchor constraintEqualToAnchor: self.bottomAnchor]
       ]];
}

@end
