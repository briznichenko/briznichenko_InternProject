//
//  LibraryViewController.h
//  briznichenkoProject
//
//  Created by briznichenko on 8/28/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LibraryModel.h"

@class EarthEventsViewController, SavedNearEarthEventsViewController, SavedNearEarthObjectsViewController, SpaceObjectsViewController;
@interface LibraryViewController : UIViewController
<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) LibraryModel *libraryModel;
@property (strong, nonatomic) IBOutlet UICollectionView *libraryCollection;

@property (nonatomic, strong) EarthEventsViewController *savedEarthEventsVC;
@property (nonatomic, strong) SavedNearEarthEventsViewController *savedNearEarthEventsVC;
@property (nonatomic, strong) SavedNearEarthObjectsViewController *savedNearEarthObjectsVC;
@property (nonatomic, strong) SpaceObjectsViewController *savedSpaceObjectsVC;

@end
