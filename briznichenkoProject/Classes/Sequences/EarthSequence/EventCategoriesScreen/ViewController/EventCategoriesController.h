//
//  EventCategoriesCollectionController.h
//  briznichenkoProject
//
//  Created by briznichenko on 8/18/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventCategoriesModel.h"

@class EventsTableController;
@interface EventCategoriesController : UIViewController
<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) EventCategoriesModel *categoriesModel;
@property (weak, nonatomic) IBOutlet UICollectionView *eventCategoriesCollection;

@property (nonatomic, strong) EventsTableController *eventsTableController;

@end
