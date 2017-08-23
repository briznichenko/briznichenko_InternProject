//
//  NearEarthObjectsController.h
//  briznichenkoProject
//
//  Created by briznichenko on 23/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NearEarthObjectsViewController.h"
#import "NearEarthObjectsModel.h"

@interface NearEarthObjectsController : NSObject
<NearEarthObjectsViewControllerProtocol, NearEarthObjectsControllerProtocol, NearEarthObjectsModelProtocol>

@property (nonatomic, strong) NearEarthObjectsViewController* nearEarthObjectsViewController;
@property (nonatomic, strong) NearEarthObjectsModel* nearEarthObjectsModel;

-(instancetype) initAndAssemble;

@end
