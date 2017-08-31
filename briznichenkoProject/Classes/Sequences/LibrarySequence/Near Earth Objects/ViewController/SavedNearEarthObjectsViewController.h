//
//  SavedNearEarthObjectsViewController.h
//  briznichenkoProject
//
//  Created by briznichenko on 8/30/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SavedNearEarthObjectsModel.h"

@class NearEarthObjectDetailController;
@interface SavedNearEarthObjectsViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *nearEarthObjectsTable;
@property (nonatomic, strong) SavedNearEarthObjectsModel *nearEarthObjectsModel;

@property (nonatomic, strong) NearEarthObjectDetailController *nearEarthObjectDetailController;

-(void) setupModelWithData: (NSArray *)data;

@end
