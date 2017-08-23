//
//  WeatherScreenView.h
//  briznichenkoProject
//
//  Created by briznichenko on 21/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WeatherScreenView : UIView

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) UILabel *humidityLabel;
@property (nonatomic, strong) UILabel *pressureLabel;

@property (nonatomic, strong) UILabel *avgTemperatureLabel;
@property (nonatomic, strong) UILabel *maxTemperatureLabel;
@property (nonatomic, strong) UILabel *minTemperatureLabel;

@property (nonatomic, strong) UILabel *sunsetLabel;
@property (nonatomic, strong) UILabel *sunriseLabel;

@property (nonatomic, strong) UILabel *cloudsLevelLabel;
@property (nonatomic, strong) UILabel *windSpeedLabel;
@property (nonatomic, strong) UILabel *visibilityLabel;

@property (nonatomic, strong) UIImageView *visibleStarsImageView;
@property (nonatomic, strong) UILabel *locationLabel;

@property (nonatomic, strong) UIImageView *weatherImage;

-(instancetype)initAndInstallIntoSuperView:(UIView *) superview topY:(float) topY;

@end
