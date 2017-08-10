//
//  ViewerController.h
//  briznichenkoProject
//
//  Created by briznichenko on 01/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ViewerViewController.h"
#import "ViewerModel.h"

@class SharingController;

@interface ViewerController : NSObject
<ViewerViewControllerProtocol, ViewerControllerProtocol, ViewerModelProtocol>

@property (nonatomic, strong) ViewerViewController* viewerViewController;
@property (nonatomic, strong) ViewerModel* viewerModel;

@property (nonatomic, strong) SharingController *sharingController;

-(instancetype) initAndAssemble;

@end
