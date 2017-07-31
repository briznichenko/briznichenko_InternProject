//
//  PopupView.m
//  briznichenkoProject
//
//  Created by briznichenko on 7/27/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "PopupView.h"

@implementation PopupView

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
    [self makeLabels];
    [self makeButtons];
}

-(void) makeLabels
{
    self.celestialBodyNameLabel = [UILabel new];
    self.celestialBodyNameLabel.text = @"PLACEHOLDER NAME";
    [self addSubview:self.celestialBodyNameLabel];
    
    self.celestialBodyRaDecLabel = [UILabel new];
    self.celestialBodyRaDecLabel.text = @"X:     Y:     ";
    [self addSubview:self.celestialBodyRaDecLabel];
}

- (void) makeButtons
{
    float borderWidth = 0.5f;
    
    self.descriptionButton = [UIButton buttonWithType:UIButtonTypePlain];
    self.descriptionButton.titleLabel.text = @"Description";
    self.descriptionButton.layer.borderWidth = borderWidth;
    self.descriptionButton.layer.borderColor = [UIColor blackColor].CGColor;
    [self addSubview:self.descriptionButton];
    
    self.galleryButton = [UIButton buttonWithType:UIButtonTypePlain];
    self.galleryButton.titleLabel.text = @"Imagery";
    self.galleryButton.layer.borderWidth = borderWidth;
    self.galleryButton.layer.borderColor = [UIColor blackColor].CGColor;
    [self addSubview:self.galleryButton];
}

- (void) makeInnerConstraints
{
    float buttonWidthMultiplier = 0.5f;
    float heightMultiplier = 0.5f;
    
    self.celestialBodyNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.celestialBodyRaDecLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.descriptionButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.galleryButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:
     @[[self.celestialBodyNameLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
       [self.celestialBodyNameLabel.topAnchor constraintEqualToAnchor:self.topAnchor],
       [self.celestialBodyNameLabel.widthAnchor constraintEqualToAnchor:self.widthAnchor],
       [self.celestialBodyNameLabel.heightAnchor constraintEqualToAnchor:self.heightAnchor multiplier: heightMultiplier / 2],
       
       [self.celestialBodyRaDecLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
       [self.celestialBodyRaDecLabel.topAnchor constraintEqualToAnchor:self.celestialBodyNameLabel.bottomAnchor],
       [self.celestialBodyRaDecLabel.heightAnchor constraintEqualToAnchor:self.heightAnchor multiplier: heightMultiplier / 2],
              
       [self.descriptionButton.leftAnchor constraintEqualToAnchor:self.leftAnchor],
       [self.descriptionButton.rightAnchor constraintEqualToAnchor:self.centerXAnchor],
       [self.descriptionButton.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
       [self.descriptionButton.widthAnchor constraintEqualToAnchor:self.widthAnchor multiplier: buttonWidthMultiplier],
       [self.descriptionButton.heightAnchor constraintEqualToAnchor:self.heightAnchor multiplier: heightMultiplier],
       
       [self.galleryButton.leftAnchor constraintEqualToAnchor:self.centerXAnchor],
       [self.galleryButton.rightAnchor constraintEqualToAnchor:self.rightAnchor],
       [self.galleryButton.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
       [self.galleryButton.widthAnchor constraintEqualToAnchor:self.widthAnchor multiplier: buttonWidthMultiplier],
       [self.galleryButton.heightAnchor constraintEqualToAnchor:self.heightAnchor multiplier: heightMultiplier]
       ]];
}

- (void) makeOuterConstraints:(UIView *) superview
{
    [superview addSubview:self];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:
     @[[self.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
       [self.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
       [self.widthAnchor constraintEqualToAnchor: self.celestialBodyRaDecLabel.widthAnchor],
       [self.heightAnchor constraintEqualToConstant: 60.0f]
       ]];
}

@end
