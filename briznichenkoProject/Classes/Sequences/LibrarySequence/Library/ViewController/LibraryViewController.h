//
//  LibraryViewController.h
//  briznichenkoProject
//
//  Created by briznichenko on 8/28/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LibraryModel.h"

@interface LibraryViewController : UIViewController
<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) LibraryModel *libraryModel;
@property (strong, nonatomic) IBOutlet UICollectionView *libraryCollection;

@end
