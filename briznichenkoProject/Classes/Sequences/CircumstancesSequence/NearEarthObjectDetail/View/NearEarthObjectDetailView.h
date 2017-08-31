//
//  NearEarthObjectDetailView.h
//  briznichenkoProject
//
//  Created by briznichenko on 23/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NearEarthObjectDetailView : UIView 

@property (nonatomic, strong) UITableView *orbitalDataView;
@property (nonatomic, strong) UITableView *closeApproachDataView;

@property (nonatomic, strong) UILabel *objectNameLabel;
@property (nonatomic, strong) UILabel *objectMagnitudeLabel;
@property (nonatomic, strong) UILabel *objectHazardousLabel;

@property (nonatomic, strong) UILabel *diameterSchemeView;
@property (nonatomic, strong) UILabel *diameterKMLabel;
@property (nonatomic, strong) UILabel *diameterMeterLabel;
@property (nonatomic, strong) UILabel *diameterFeetLabel;
@property (nonatomic, strong) UILabel *diameterMilesLabel;

@property (nonatomic, strong) UIWebView *objectNasaView;

-(instancetype)initAndInstallIntoSuperView:(UIView *) superview topY:(float) topY;

@end
