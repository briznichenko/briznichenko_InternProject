//
//  NearEarthEventsController.h
//  briznichenkoProject
//
//  Created by briznichenko on 23/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NearEarthEventsViewController.h"
#import "NearEarthEventsModel.h"

@interface NearEarthEventsController : NSObject
<NearEarthEventsViewControllerProtocol, NearEarthEventsControllerProtocol, NearEarthEventsModelProtocol>

@property (nonatomic, strong) NearEarthEventsViewController* nearEarthEventsViewController;
@property (nonatomic, strong) NearEarthEventsModel* nearEarthEventsModel;

-(instancetype) initAndAssemble;

@end
