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
#import "NearEarthObjectEntity.h"

@interface NearEarthObjectDetailViewController : UIViewController
<NearEarthObjectDetailViewControllerProtocol, UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate>

@property (nonatomic, strong) NearEarthObjectDetailView* nearEarthObjectDetailView;
@property (atomic, strong) NearEarthObjectEntity *objectEntity;

- (void) showSavedAlert;

@end
