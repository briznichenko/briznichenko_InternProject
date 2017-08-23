//
//  NearEarthObjectDetailViewController.h
//  briznichenkoProject
//
//  Created by briznichenko on 23/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearEarthObjectDetailProtocols.h"
#import "NearEarthObjectDetailView.h"

@interface NearEarthObjectDetailViewController : UIViewController
<NearEarthObjectDetailViewControllerProtocol>

@property (nonatomic, strong) NearEarthObjectDetailView* nearEarthObjectDetailView;

@end
