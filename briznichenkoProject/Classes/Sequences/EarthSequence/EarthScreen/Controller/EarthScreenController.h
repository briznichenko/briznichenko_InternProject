//
//  EarthScreenController.h
//  briznichenkoProject
//
//  Created by briznichenko on 04/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "EarthScreenViewController.h"
#import "EarthScreenModel.h"

//@class
@interface EarthScreenController : NSObject
<EarthScreenViewControllerProtocol, EarthScreenControllerProtocol, EarthScreenModelProtocol>

@property (nonatomic, strong) EarthScreenViewController* earthscreenViewController;
@property (nonatomic, strong) EarthScreenModel* earthscreenModel;

-(instancetype) initAndAssemble;

@end
