//
//  GalleryView.h
//  briznichenkoProject
//
//  Created by briznichenko on 31/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GalleryView : UIView

@property (nonatomic, strong) UICollectionView *imageryCollection;

-(instancetype)initAndInstallIntoSuperView:(UIView *) superview;

@end
