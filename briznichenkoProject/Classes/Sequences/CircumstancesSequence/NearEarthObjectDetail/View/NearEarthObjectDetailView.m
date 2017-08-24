//
//  NearEarthObjectDetailView.m
//  briznichenkoProject
//
//  Created by briznichenko on 23/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "NearEarthObjectDetailView.h"


@implementation NearEarthObjectDetailView


-(instancetype)initAndInstallIntoSuperView:(UIView *) superview topY:(float) topY
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
    [self makeBasicDataView];
    [self makeDiameterView];
    [self makeOrbitalTable];
    [self makeApproachData];
    [self makeNasaView];
}

- (void) makeBasicDataView
{
    float borderWidth = 0.5f;
    
    self.objectNameLabel = [UILabel new];
    self.objectNameLabel.text = @"I'm an object!";
    self.objectNameLabel.layer.borderColor = [UIColor blackColor].CGColor;
    self.objectNameLabel.layer.borderWidth = borderWidth;
    self.objectNameLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.objectNameLabel];
    
    self.objectMagnitudeLabel = [UILabel new];
    self.objectMagnitudeLabel.text = @"I'm big!";
    [self addSubview:self.objectMagnitudeLabel];
    
    self.objectHazardousLabel = [UILabel new];
    self.objectHazardousLabel.text = @"I'm hazardous!";
    [self addSubview:self.objectHazardousLabel];
}

- (void) makeDiameterView
{
    float borderWidth = 0.5f;
    
    self.diameterSchemeView = [UILabel new];
    self.diameterSchemeView.text = @"Diameter";
    self.diameterSchemeView.textAlignment = NSTextAlignmentCenter;
    self.diameterSchemeView.layer.borderColor = [UIColor blackColor].CGColor;
    self.diameterSchemeView.layer.borderWidth = borderWidth;
    [self addSubview:self.diameterSchemeView];
    
    self.diameterKMLabel = [UILabel new];
    self.diameterKMLabel.text = @".. km";
    [self addSubview:self.diameterKMLabel];
    
    self.diameterMeterLabel = [UILabel new];
    self.diameterMeterLabel.text = @".. m";
    [self addSubview:self.diameterMeterLabel];
    
    self.diameterFeetLabel = [UILabel new];
    self.diameterFeetLabel.text = @".. feet";
    [self addSubview:self.diameterFeetLabel];
    
    self.diameterMilesLabel = [UILabel new];
    self.diameterMilesLabel.text = @".. miles";
    [self addSubview:self.diameterMilesLabel];
}

- (void) makeOrbitalTable
{
    self.orbitalDataView = [UITableView new];
    [self addSubview:self.orbitalDataView];
}

- (void) makeApproachData
{
    self.closeApproachDataView = [UITableView new];
    [self addSubview:self.closeApproachDataView];
}

- (void) makeNasaView
{
    self.objectNasaView = [UIWebView new];
    [self addSubview:self.objectNasaView];
}

- (void) makeInnerConstraints
{
    float widthMultiplier = 1.0f/3.0f;
    
    self.orbitalDataView.translatesAutoresizingMaskIntoConstraints = NO;
    self.closeApproachDataView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.objectNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.objectMagnitudeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.objectHazardousLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.diameterSchemeView.translatesAutoresizingMaskIntoConstraints = NO;
    self.diameterKMLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.diameterMeterLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.diameterFeetLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.diameterMilesLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.objectNasaView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:
     @[[self.objectNameLabel.topAnchor constraintEqualToAnchor:self.topAnchor],
       [self.objectNameLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
       [self.objectNameLabel.widthAnchor constraintEqualToAnchor:self.widthAnchor multiplier:widthMultiplier],
       
       [self.objectMagnitudeLabel.topAnchor constraintEqualToAnchor:self.objectNameLabel.bottomAnchor],
       [self.objectMagnitudeLabel.centerXAnchor constraintEqualToAnchor:self.objectNameLabel.centerXAnchor],
       [self.objectMagnitudeLabel.widthAnchor constraintEqualToAnchor:self.objectNameLabel.widthAnchor],
       
       [self.objectHazardousLabel.topAnchor constraintEqualToAnchor:self.objectMagnitudeLabel.bottomAnchor],
       [self.objectHazardousLabel.centerXAnchor constraintEqualToAnchor:self.objectMagnitudeLabel.centerXAnchor],
       [self.objectHazardousLabel.widthAnchor constraintEqualToAnchor:self.objectMagnitudeLabel.widthAnchor],
       
       [self.diameterSchemeView.topAnchor constraintEqualToAnchor:self.objectHazardousLabel.bottomAnchor],
       [self.diameterSchemeView.centerXAnchor constraintEqualToAnchor:self.objectHazardousLabel.centerXAnchor],
       [self.diameterSchemeView.widthAnchor constraintEqualToAnchor:self.objectHazardousLabel.widthAnchor],
       [self.diameterSchemeView.heightAnchor constraintEqualToAnchor:self.diameterSchemeView.widthAnchor],
       
       [self.diameterKMLabel.centerYAnchor constraintEqualToAnchor:self.diameterSchemeView.topAnchor],
       [self.diameterKMLabel.centerXAnchor constraintEqualToAnchor:self.diameterSchemeView.centerXAnchor],
       
       [self.diameterMeterLabel.centerYAnchor constraintEqualToAnchor:self.diameterSchemeView.bottomAnchor],
       [self.diameterMeterLabel.centerXAnchor constraintEqualToAnchor:self.diameterSchemeView.centerXAnchor],
       
       [self.diameterFeetLabel.centerYAnchor constraintEqualToAnchor:self.diameterSchemeView.centerYAnchor],
       [self.diameterFeetLabel.centerXAnchor constraintEqualToAnchor:self.diameterSchemeView.leftAnchor],
       
       [self.diameterMilesLabel.centerYAnchor constraintEqualToAnchor:self.diameterSchemeView.centerYAnchor],
       [self.diameterMilesLabel.centerXAnchor constraintEqualToAnchor:self.diameterSchemeView.rightAnchor],
       
       [self.orbitalDataView.topAnchor constraintEqualToAnchor:self.topAnchor],
       [self.orbitalDataView.leftAnchor constraintEqualToAnchor:self.leftAnchor],
       [self.orbitalDataView.bottomAnchor constraintEqualToAnchor:self.diameterSchemeView.bottomAnchor],
       [self.orbitalDataView.widthAnchor constraintEqualToAnchor:self.diameterSchemeView.widthAnchor],
       
       [self.closeApproachDataView.topAnchor constraintEqualToAnchor:self.topAnchor],
       [self.closeApproachDataView.rightAnchor constraintEqualToAnchor:self.rightAnchor],
       [self.closeApproachDataView.bottomAnchor constraintEqualToAnchor:self.diameterSchemeView.bottomAnchor],
       [self.closeApproachDataView.widthAnchor constraintEqualToAnchor:self.diameterSchemeView.widthAnchor],
       
       [self.objectNasaView.topAnchor constraintEqualToAnchor:self.diameterSchemeView.bottomAnchor],
       [self.objectNasaView.widthAnchor constraintEqualToAnchor:self.widthAnchor],
       [self.objectNasaView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor]
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
