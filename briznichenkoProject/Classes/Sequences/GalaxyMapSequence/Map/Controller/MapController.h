//
//  MapController.h
//  briznichenkoProject
//
//  Created by briznichenko on 18/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "MapViewController.h"
#import "MapModel.h"
#import "MapProtocols.h"

@class DescriptionController;
@class GalleryController;
@interface MapController : NSObject
<MapModelProtocol, MapViewControllerProtocol>

@property (nonatomic, strong) MapViewController* mapViewController;
@property (nonatomic, strong) MapModel* mapModel;

@property (nonatomic, strong) DescriptionController *descriptionController;
@property (nonatomic, strong) GalleryController *galleryController;

-(instancetype) initAndAssemble;

@end
