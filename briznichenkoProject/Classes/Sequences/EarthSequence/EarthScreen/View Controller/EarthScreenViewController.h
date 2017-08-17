//
//  EarthScreenViewController.h
//  briznichenkoProject
//
//  Created by briznichenko on 8/16/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EarthScreenModel.h"

@class EPICImageryViewController, FlatEarthViewController;
@interface EarthScreenViewController : UIViewController

@property (nonatomic, strong) EarthScreenModel *earthScreenModel;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *eventsButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *earthViewSwitcher;
@property (weak, nonatomic) IBOutlet UIView *earthScreenViewContainer;
@property (weak, nonatomic) IBOutlet UIView *earthFlatViewContainer;

@property (nonatomic, strong) EPICImageryViewController *epicImageryController;
@property (nonatomic, strong) FlatEarthViewController *flatEarthController;

-(void) fetchImages;

@end
