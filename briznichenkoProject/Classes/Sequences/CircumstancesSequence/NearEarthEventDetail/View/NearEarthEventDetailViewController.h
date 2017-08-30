//
//  NearEarthEventDetailViewController.h
//  briznichenkoProject
//
//  Created by briznichenko on 23/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearEarthEventDetailProtocols.h"
#import "NearEarthEventDetailView.h"
#import "NearEarthEventEntity.h"

@interface NearEarthEventDetailViewController : UIViewController
<NearEarthEventDetailViewControllerProtocol>

@property (nonatomic, strong) NearEarthEventDetailView* nearEarthEventDetailView;
@property (nonatomic, strong) NearEarthEventEntity *eventEntity;

- (void) showSavedAlert;

@end
