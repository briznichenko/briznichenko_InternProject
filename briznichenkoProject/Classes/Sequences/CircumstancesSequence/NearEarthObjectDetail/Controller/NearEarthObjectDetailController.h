//
//  NearEarthObjectDetailController.h
//  briznichenkoProject
//
//  Created by briznichenko on 23/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NearEarthObjectDetailViewController.h"
#import "NearEarthObjectDetailModel.h"

@class SharingController;
@interface NearEarthObjectDetailController : NSObject
<NearEarthObjectDetailViewControllerProtocol, NearEarthObjectDetailControllerProtocol, NearEarthObjectDetailModelProtocol>

@property (nonatomic, strong) NearEarthObjectDetailViewController* nearEarthObjectDetailViewController;
@property (nonatomic, strong) NearEarthObjectDetailModel* nearEarthObjectDetailModel;

@property (nonatomic, strong) SharingController *sharingController;

-(instancetype) initAndAssemble;
-(void) setupWithEntity;

@end
