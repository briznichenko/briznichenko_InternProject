//
//  NearEarthObjectsViewController.h
//  briznichenkoProject
//
//  Created by briznichenko on 23/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearEarthObjectsProtocols.h"
#import "NearEarthObjectsView.h"

@interface NearEarthObjectsViewController : UIViewController
<NearEarthObjectsViewControllerProtocol, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NearEarthObjectsView* nearEarthObjectsView;

@property (nonatomic, strong) NSDictionary* nearEarthObjects;

@end
