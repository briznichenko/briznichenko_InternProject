//
//  EPICImageryViewController.h
//  briznichenkoProject
//
//  Created by briznichenko on 8/16/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EPICImageryViewController : UIViewController
<UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *imageryArray;

@property (weak, nonatomic) IBOutlet UICollectionView *imageryCollection;

-(void) updateImagery;

@end
