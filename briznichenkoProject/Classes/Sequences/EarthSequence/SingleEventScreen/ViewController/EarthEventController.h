//
//  EarthEventController.h
//  briznichenkoProject
//
//  Created by briznichenko on 8/18/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EarthEventModel.h"
#import "EarthEventEntity.h"

@class SharingController;
@interface EarthEventController : UIViewController
<UIWebViewDelegate>

@property (nonatomic, strong) EarthEventEntity *eventEntity;
@property (nonatomic, strong) EarthEventModel *eventModel;

@property (weak, nonatomic) IBOutlet UILabel *eventTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIWebView *eventWebView;

@property (nonatomic, strong) SharingController *sharingController;

@end
