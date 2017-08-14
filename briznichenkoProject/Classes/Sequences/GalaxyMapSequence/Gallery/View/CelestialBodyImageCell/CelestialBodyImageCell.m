//
//  CelestialBodyImageCell.m
//  briznichenkoProject
//
//  Created by briznichenko on 7/31/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "CelestialBodyImageCell.h"

@implementation CelestialBodyImageCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self makeView];
    }
    return self;
}

- (void) makeView
{
    self.backgroundColor = [UIColor whiteColor];
    [self makeObjectImageView];
}

-(void) makeObjectImageView
{
    self.objectImageView = [UIImageView new];
    [self addSubview:self.objectImageView];
    [self makeObjectImageViewConstraints];
}

-(void) makeObjectImageViewConstraints
{
    
    self.objectImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:
     @[[self.objectImageView.centerXAnchor constraintEqualToAnchor: self.centerXAnchor],
       [self.objectImageView.centerYAnchor constraintEqualToAnchor: self.centerYAnchor],
       [self.objectImageView.widthAnchor constraintEqualToAnchor: self.widthAnchor],
       [self.objectImageView.heightAnchor constraintEqualToAnchor: self.heightAnchor]
       ]];
}

@end
