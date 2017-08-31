//
//  NearEarthEventsViewController.h
//  briznichenkoProject
//
//  Created by briznichenko on 8/30/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SavedNearEarthEventsModel.h"

@class NearEarthEventDetailController;
@interface SavedNearEarthEventsViewController : UIViewController
<UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) IBOutlet UICollectionView *nearEarthEventsCollection;
@property (nonatomic, strong) SavedNearEarthEventsModel *nearEarthEventsModel;

@property (nonatomic, strong) NearEarthEventDetailController *nearEarthEventDetailController;

-(void) setupModelWithData: (NSArray *)data;

@end
