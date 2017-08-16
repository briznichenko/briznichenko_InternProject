//
//  RootNavigationController.h
//  briznichenkoProject
//
//  Created by briznichenko on 7/25/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SideMenuProtocols.h"

@class SideMenuController;
@class MapController;
@class EarthScreenViewController;
//@class ;
//@class ;

@interface RootNavigationController : UINavigationController
<SideMenuControllerProtocol>

@property(nonatomic, strong) SideMenuController *sideMenuController;

@property (nonatomic, strong) MapController *mapController;
@property (nonatomic, strong) EarthScreenViewController *earthScreenViewController;

- (instancetype) initWithInitialViewController;

- (void) presentMapController;
- (void) presentEarthScreenController;

@end
