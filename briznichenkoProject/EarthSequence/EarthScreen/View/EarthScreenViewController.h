//
//  EarthScreenViewController.h
//  briznichenkoProject
//
//  Created by briznichenko on 04/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EarthScreenProtocols.h"
#import "EarthScreenView.h"

@interface EarthScreenViewController : UIViewController
<EarthScreenViewControllerProtocol>

@property (nonatomic, strong) EarthScreenView* earthscreenView;

@end
