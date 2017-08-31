//
//  EventsTableController.h
//  briznichenkoProject
//
//  Created by briznichenko on 8/18/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventsTableModel.h"

@class EarthEventController;
@interface EventsTableController : UIViewController
<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) EventsTableModel *eventsTableModel;
@property int tag;

@property (weak, nonatomic) IBOutlet UITableView *eventsTable;

@property (nonatomic, strong) EarthEventController *eventController;

@end
