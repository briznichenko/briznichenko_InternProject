//
//  DescriptionViewController.h
//  briznichenkoProject
//
//  Created by briznichenko on 31/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DescriptionProtocols.h"
#import "DescriptionView.h"

@class CelestialBodyEntity;
@interface DescriptionViewController : UIViewController
<DescriptionViewControllerProtocol>

@property (nonatomic, strong) DescriptionView *descriptionView;
@property (nonatomic, strong) CelestialBodyEntity *bodyEntity;

- (void) showSavedAlert;

@end
