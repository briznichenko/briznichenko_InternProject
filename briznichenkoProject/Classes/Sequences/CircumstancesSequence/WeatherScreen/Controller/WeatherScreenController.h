//
//  WeatherScreenController.h
//  briznichenkoProject
//
//  Created by briznichenko on 21/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "WeatherScreenViewController.h"
#import "WeatherScreenModel.h"

@class NearEarthEventsController, NearEarthObjectsController;
@interface WeatherScreenController : NSObject
<WeatherScreenViewControllerProtocol, WeatherScreenControllerProtocol, WeatherScreenModelProtocol>

@property (nonatomic, strong) WeatherScreenViewController* weatherScreenViewController;
@property (nonatomic, strong) WeatherScreenModel* weatherScreenModel;

@property (nonatomic, strong) NearEarthEventsController* nearEarthEventsController;
@property (nonatomic, strong) NearEarthObjectsController* nearEarthObjectsController;

-(instancetype) initAndAssemble;

@end
