//
//  GalleryViewController.h
//  briznichenkoProject
//
//  Created by briznichenko on 31/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GalleryProtocols.h"
#import "GalleryView.h"

@interface GalleryViewController : UIViewController
<GalleryViewControllerProtocol, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) GalleryView *galleryView;

@end
