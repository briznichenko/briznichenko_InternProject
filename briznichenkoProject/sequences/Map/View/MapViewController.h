//
//  MapViewController.h
//  briznichenkoProject
//
//  Created by briznichenko on 18/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapProtocols.h"
#import "MapView.h"
#import "PopupView.h"

@class CelestialBodyEntity;
@interface MapViewController : UIViewController
<MapViewControllerProtocol, UIWebViewDelegate, UIGestureRecognizerDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) MapView* mapView;
@property (nonatomic, strong) PopupView* popupView;
@property (nonatomic, strong) CelestialBodyEntity *bodyEntity;
@property (nonatomic, strong) NSDictionary *celestialBodyData;

@property (nonatomic) bool isReady;

-(void) presentObjectPopup;

@end
