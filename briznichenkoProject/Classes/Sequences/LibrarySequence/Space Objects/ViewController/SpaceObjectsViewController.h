//
//  SpaceObjectsViewController.h
//  briznichenkoProject
//
//  Created by briznichenko on 8/30/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpaceObjectsModel.h"

@class DescriptionController;
@interface SpaceObjectsViewController : UIViewController
<UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *spaceObjectsCollection;
@property (nonatomic, strong) SpaceObjectsModel *spaceObjectsModel;

@property (nonatomic, strong) DescriptionController *descriptionController;

-(void) setupModelWithData: (NSArray *)data;

@end
