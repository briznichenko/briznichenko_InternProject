//
//  NearEarthEventDetailView.m
//  briznichenkoProject
//
//  Created by briznichenko on 23/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "NearEarthEventDetailView.h"


@implementation NearEarthEventDetailView


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
    [self makeEventImage];
    [self makeEventImage];
    [self makeEventTitleField];
    [self makeEventDateField];
    [self makeEventType];
    [self makeEventDescriptionView];
    
    [self test];
}

- (void) makeEventImage
{
    self.eventImageView = [UIImageView new];
    [self addSubview:self.eventImageView];
    
    self.eventImageDescriptionField = [UILabel new];
    self.eventImageDescriptionField.text = @"placeholder_description";
    [self addSubview:self.eventImageDescriptionField];
}

- (void) makeEventTitleField
{
    self.eventTitleField = [UILabel new];
    self.eventTitleField.text = @"placeholder_title";
    [self addSubview:self.eventTitleField];
}

- (void) makeEventDateField
{
    self.eventDateField = [UILabel new];
    self.eventDateField.text = @"placeholder_date";
    [self addSubview:self.eventDateField];
}

- (void) makeEventType
{
    self.eventTypeIconImageView = [UIImageView new];
    [self addSubview:self.eventTypeIconImageView];
    
    self.eventTypeIconDescriptionField = [UILabel new];
    self.eventTypeIconDescriptionField.text = @"placeholder_icon_description";
    [self addSubview:self.eventTypeIconDescriptionField];
}

- (void) makeEventDescriptionView
{
    self.eventDescriptionView = [UITextView new];
    self.eventDescriptionView.editable = NO;
    [self addSubview:self.eventDescriptionView];
}

- (void) makeInnerConstraints
{
    float eventImageSizeMultiplier = 1.0/3.0f;
    float eventImageIconSizeMultiplier = 0.2f;
    
    self.eventImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.eventImageDescriptionField.translatesAutoresizingMaskIntoConstraints = NO;
    self.eventTitleField.translatesAutoresizingMaskIntoConstraints = NO;
    self.eventDateField.translatesAutoresizingMaskIntoConstraints = NO;
    self.eventTypeIconImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.eventTypeIconDescriptionField.translatesAutoresizingMaskIntoConstraints = NO;
    self.eventDescriptionView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:
     @[[self.eventImageView.topAnchor constraintEqualToAnchor:self.topAnchor],
       [self.eventImageView.leftAnchor constraintEqualToAnchor:self.leftAnchor],
       [self.eventImageView.widthAnchor constraintEqualToAnchor:self.widthAnchor multiplier:eventImageSizeMultiplier],
       [self.eventImageView.heightAnchor constraintEqualToAnchor:self.eventImageView.widthAnchor],
       
       [self.eventImageDescriptionField.topAnchor constraintEqualToAnchor:self.eventImageView.bottomAnchor],
       [self.eventImageDescriptionField.leftAnchor constraintEqualToAnchor:self.leftAnchor],
       
       [self.eventTitleField.topAnchor constraintEqualToAnchor:self.topAnchor],
       [self.eventTitleField.leftAnchor constraintEqualToAnchor:self.eventImageView.rightAnchor],
       
       [self.eventDateField.topAnchor constraintEqualToAnchor:self.eventTitleField.bottomAnchor],
       [self.eventDateField.leftAnchor constraintEqualToAnchor:self.eventImageView.rightAnchor],
       
       [self.eventTypeIconImageView.topAnchor constraintEqualToAnchor:self.eventTitleField.bottomAnchor],
       [self.eventTypeIconImageView.rightAnchor constraintEqualToAnchor:self.rightAnchor],
       [self.eventTypeIconImageView.widthAnchor constraintEqualToAnchor:self.widthAnchor multiplier:eventImageIconSizeMultiplier],
       [self.eventTypeIconImageView.heightAnchor constraintEqualToAnchor:self.eventTypeIconImageView.widthAnchor],
       
       [self.eventTypeIconDescriptionField.topAnchor constraintEqualToAnchor:self.eventTypeIconImageView.bottomAnchor],
       [self.eventTypeIconDescriptionField.rightAnchor constraintEqualToAnchor:self.rightAnchor],
     	
       [self.eventDescriptionView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
       [self.eventDescriptionView.topAnchor constraintEqualToAnchor:self.eventImageDescriptionField.bottomAnchor],
       [self.eventDescriptionView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
       [self.eventDescriptionView.widthAnchor constraintEqualToAnchor:self.widthAnchor]
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
