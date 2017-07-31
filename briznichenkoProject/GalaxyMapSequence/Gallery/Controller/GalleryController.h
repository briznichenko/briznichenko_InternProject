//
//  GalleryController.h
//  briznichenkoProject
//
//  Created by briznichenko on 31/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "GalleryViewController.h"
#import "GalleryModel.h"

@interface GalleryController : NSObject
<GalleryViewControllerProtocol, GalleryControllerProtocol, GalleryModelProtocol>

@property (nonatomic, strong) GalleryViewController* galleryViewController;
@property (nonatomic, strong) GalleryModel* galleryModel;

-(instancetype) initAndAssemble;

@end
