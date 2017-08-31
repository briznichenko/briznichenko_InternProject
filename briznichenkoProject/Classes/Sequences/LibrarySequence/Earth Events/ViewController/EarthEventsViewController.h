//
//  EarthEventsViewController.h
//  briznichenkoProject
//
//  Created by briznichenko on 8/30/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EarthEventsModel.h"

@class EarthEventController;
@interface EarthEventsViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *earthEventsTable;
@property (nonatomic, strong) EarthEventsModel *earthEventsModel;

@property (nonatomic, strong) EarthEventController *earthEventController;

-(void) setupModelWithData: (NSArray *)data;

@end
