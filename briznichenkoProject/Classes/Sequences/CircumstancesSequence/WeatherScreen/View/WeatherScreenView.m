//
//  WeatherScreenView.m
//  briznichenkoProject
//
//  Created by briznichenko on 21/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "WeatherScreenView.h"


@implementation WeatherScreenView
{
    NSArray *labels;
    
    UIView *leftAccessory;
    UIView *rightAccessory;
    UIView *centerAccessory;
}

@synthesize humidityLabel,pressureLabel,avgTemperatureLabel,maxTemperatureLabel,minTemperatureLabel,sunsetLabel,sunriseLabel,cloudsLevelLabel,windSpeedLabel,visibilityLabel;


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
    [self makeHeaderView];
    [self makeStarsImageView];
    [self makeLocationLabel];
}

- (void) makeStarsImageView
{
    self.visibleStarsImageView = [UIImageView new];
    self.visibleStarsImageView.layer.borderWidth = 2.0f;
    self.visibleStarsImageView.layer.borderColor = [UIColor blueColor].CGColor;
    [self addSubview:self.visibleStarsImageView];
}

- (void) makeHeaderView
{
    self.headerView = [UIView new];
    self.headerView.layer.borderWidth = 2.0f;
    self.headerView.layer.borderColor = [UIColor orangeColor].CGColor;
    [self addSubview:self.headerView];
    
    leftAccessory = [UIView new];
    leftAccessory.backgroundColor = [UIColor lightGrayColor];
    [self.headerView addSubview:leftAccessory];
    
    rightAccessory = [UIView new];
    rightAccessory.backgroundColor = [UIColor grayColor];
    [self.headerView addSubview:rightAccessory];
    
    centerAccessory = [UIView new];
    centerAccessory.layer.borderWidth = 2.0f;
    centerAccessory.layer.borderColor = [UIColor orangeColor].CGColor;
    centerAccessory.backgroundColor = [UIColor darkGrayColor];
    [self.headerView addSubview:centerAccessory];
    
    humidityLabel       = [UILabel new];
    pressureLabel       = [UILabel new];
    avgTemperatureLabel = [UILabel new];
    maxTemperatureLabel = [UILabel new];
    minTemperatureLabel = [UILabel new];
    sunsetLabel         = [UILabel new];
    sunriseLabel        = [UILabel new];
    cloudsLevelLabel    = [UILabel new];
    windSpeedLabel      = [UILabel new];
    visibilityLabel     = [UILabel new];
    
    humidityLabel.adjustsFontSizeToFitWidth = YES;
    pressureLabel.adjustsFontSizeToFitWidth = YES;
    avgTemperatureLabel.adjustsFontSizeToFitWidth = YES;
    maxTemperatureLabel.adjustsFontSizeToFitWidth = YES;
    minTemperatureLabel.adjustsFontSizeToFitWidth = YES;
    
    NSArray *labelText = @[@"hum",
                           @"pres",
                           @"avgT",
                           @"maxT",
                           @"minT",
                           @"set",
                           @"rise",
                           @"clouds",
                           @"wind",
                           @"vis"];
    labels = @[humidityLabel,pressureLabel,avgTemperatureLabel,maxTemperatureLabel,minTemperatureLabel,sunsetLabel,sunriseLabel,cloudsLevelLabel,windSpeedLabel,visibilityLabel];
    for(UILabel *label in labels)
        label.text = labelText[[labels indexOfObject:label]];
    for(int i = 0; i < labels.count; i++)
        if(i < 5)
            [leftAccessory addSubview:labels[i]];
        else if(i >= 5)
            [centerAccessory addSubview:labels[i]];
    
    self.weatherImage = [UIImageView new];
    [rightAccessory addSubview:self.weatherImage];
}

- (void) makeLocationLabel
{
    self.locationLabel = [UILabel new];
    self.locationLabel.text = @"PLACEHOLDER LOCATION";
    [self addSubview:self.locationLabel];
}

- (void) makeInnerConstraints
{
    self.headerView.translatesAutoresizingMaskIntoConstraints = NO;
    self.visibleStarsImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.locationLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
     [self makeHeaderConstraints];
    
    [NSLayoutConstraint activateConstraints:
     @[[self.visibleStarsImageView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
       [self.visibleStarsImageView.bottomAnchor constraintEqualToAnchor:self.locationLabel.topAnchor],
       [self.visibleStarsImageView.widthAnchor constraintEqualToAnchor:self.widthAnchor],
       [self.visibleStarsImageView.heightAnchor constraintEqualToAnchor:self.visibleStarsImageView.widthAnchor],
       
       [self.headerView.topAnchor constraintEqualToAnchor:self.topAnchor],
       [self.headerView.bottomAnchor constraintEqualToAnchor:self.visibleStarsImageView.topAnchor],
       [self.headerView.widthAnchor constraintEqualToAnchor:self.widthAnchor],
       
       [self.locationLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
       [self.locationLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor]
       ]];
}

- (void) makeHeaderConstraints
{
    float widthMultiplier = 0.6f;
    
    leftAccessory.translatesAutoresizingMaskIntoConstraints = NO;
    centerAccessory.translatesAutoresizingMaskIntoConstraints = NO;
    rightAccessory.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:
     @[[centerAccessory.topAnchor constraintEqualToAnchor:self.headerView.topAnchor],
       [centerAccessory.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
       [centerAccessory.heightAnchor constraintEqualToAnchor:self.headerView.heightAnchor],
       [centerAccessory.widthAnchor constraintEqualToAnchor:self.headerView.widthAnchor multiplier:widthMultiplier],
       
       [leftAccessory.topAnchor constraintEqualToAnchor:self.headerView.topAnchor],
       [leftAccessory.leftAnchor constraintEqualToAnchor:self.leftAnchor],
       [leftAccessory.heightAnchor constraintEqualToAnchor:self.headerView.heightAnchor],
       [leftAccessory.widthAnchor constraintEqualToAnchor:self.headerView.widthAnchor multiplier:(1 - widthMultiplier) / 2],

       [rightAccessory.topAnchor constraintEqualToAnchor:self.headerView.topAnchor],
       [rightAccessory.rightAnchor constraintEqualToAnchor:self.rightAnchor],
       [rightAccessory.heightAnchor constraintEqualToAnchor:self.headerView.heightAnchor],
       [rightAccessory.widthAnchor constraintEqualToAnchor:leftAccessory.widthAnchor]
       ]];
    
    for (UILabel *label in labels)
        label.translatesAutoresizingMaskIntoConstraints = NO;
    self.weatherImage.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:
     @[[humidityLabel.topAnchor constraintEqualToAnchor:leftAccessory.topAnchor],
       [humidityLabel.leftAnchor constraintEqualToAnchor:leftAccessory.leftAnchor],
       
       [pressureLabel.topAnchor constraintEqualToAnchor:humidityLabel.bottomAnchor],
       [pressureLabel.leftAnchor constraintEqualToAnchor:leftAccessory.leftAnchor],
       
       [maxTemperatureLabel.bottomAnchor constraintEqualToAnchor:avgTemperatureLabel.topAnchor],
       [maxTemperatureLabel.leftAnchor constraintEqualToAnchor:leftAccessory.leftAnchor],
       
       [avgTemperatureLabel.bottomAnchor constraintEqualToAnchor:minTemperatureLabel.topAnchor],
       [avgTemperatureLabel.leftAnchor constraintEqualToAnchor:leftAccessory.leftAnchor],
       
       [minTemperatureLabel.bottomAnchor constraintEqualToAnchor:leftAccessory.bottomAnchor],
       [minTemperatureLabel.leftAnchor constraintEqualToAnchor:leftAccessory.leftAnchor],
       
       [sunriseLabel.centerYAnchor constraintEqualToAnchor:centerAccessory.centerYAnchor],
       [sunriseLabel.leftAnchor constraintEqualToAnchor:centerAccessory.leftAnchor],
       
       [sunsetLabel.centerYAnchor constraintEqualToAnchor:centerAccessory.centerYAnchor],
       [sunsetLabel.rightAnchor constraintEqualToAnchor:centerAccessory.rightAnchor],
       
       [cloudsLevelLabel.topAnchor constraintEqualToAnchor:centerAccessory.topAnchor],
       [cloudsLevelLabel.centerXAnchor constraintEqualToAnchor:centerAccessory.centerXAnchor],
       
       [windSpeedLabel.bottomAnchor constraintEqualToAnchor:centerAccessory.bottomAnchor],
       [windSpeedLabel.centerXAnchor constraintEqualToAnchor:centerAccessory.centerXAnchor],
       
       [visibilityLabel.centerXAnchor constraintEqualToAnchor:centerAccessory.centerXAnchor],
       [visibilityLabel.centerYAnchor constraintEqualToAnchor:centerAccessory.centerYAnchor],
       
       [self.weatherImage.centerXAnchor constraintEqualToAnchor:rightAccessory.centerXAnchor],
       [self.weatherImage.centerYAnchor constraintEqualToAnchor:rightAccessory.centerYAnchor],
       [self.weatherImage.widthAnchor constraintEqualToAnchor:rightAccessory.widthAnchor],
       [self.weatherImage.heightAnchor constraintEqualToAnchor:rightAccessory.widthAnchor]
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
