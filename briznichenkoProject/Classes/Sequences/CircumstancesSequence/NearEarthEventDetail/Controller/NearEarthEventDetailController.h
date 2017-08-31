//
//  NearEarthEventDetailController.h
//  briznichenkoProject
//
//  Created by briznichenko on 23/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NearEarthEventDetailViewController.h"
#import "NearEarthEventDetailModel.h"

@class SharingController;
@interface NearEarthEventDetailController : NSObject
<NearEarthEventDetailViewControllerProtocol, NearEarthEventDetailControllerProtocol, NearEarthEventDetailModelProtocol>

@property (nonatomic, strong) NearEarthEventDetailViewController *nearEarthEventDetailViewController;
@property (nonatomic, strong) NearEarthEventDetailModel* nearEarthEventDetailModel;

@property (nonatomic, strong) SharingController* sharingController;

- (instancetype) initAndAssembleWithEventURL: (NSURL * _Nullable) eventURL orEntity: (id _Nullable) entity;

@end
