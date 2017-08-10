//
//  SharingController.h
//  briznichenkoProject
//
//  Created by briznichenko on 09/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SharingViewController.h"
#import "SharingModel.h"

@interface SharingController : NSObject
<SharingViewControllerProtocol, SharingControllerProtocol, SharingModelProtocol>

@property (nonatomic, strong) SharingViewController* sharingViewController;
@property (nonatomic, strong) SharingModel* sharingModel;

-(instancetype) initAndAssembleWithShareURL: (NSString *)shareURL;

@end
