//
//  EarthEventController.h
//  briznichenkoProject
//
//  Created by briznichenko on 8/18/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EarthEventEntity.h"

@interface EarthEventController : UIViewController

@property (nonatomic, strong) EarthEventEntity *eventEntity;
@property (weak, nonatomic) IBOutlet UILabel *eventTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIWebView *eventWebView;

@end
