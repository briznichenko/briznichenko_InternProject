//
//  DescriptionController.h
//  briznichenkoProject
//
//  Created by briznichenko on 31/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "DescriptionViewController.h"
#import "DescriptionModel.h"

@class GalleryController;
@interface DescriptionController : NSObject
<DescriptionViewControllerProtocol, DescriptionControllerProtocol, DescriptionModelProtocol>

@property (nonatomic, strong) DescriptionViewController* descriptionViewController;
@property (nonatomic, strong) DescriptionModel* descriptionModel;

@property (nonatomic, strong) GalleryController *galleryController;

-(instancetype) initAndAssembleWithData: (id) data;
@end
