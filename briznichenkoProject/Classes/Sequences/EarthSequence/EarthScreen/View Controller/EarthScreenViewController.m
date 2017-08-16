//
//  EarthScreenViewController.m
//  briznichenkoProject
//
//  Created by briznichenko on 8/16/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "EarthScreenViewController.h"
#import "EPICImageryViewController.h"

@interface EarthScreenViewController ()

@end

@implementation EarthScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewController];
}

- (void)setupViewController
{
    self.earthScreenModel = [[EarthScreenModel alloc] initWithData];
    self.dateLabel.text = [NSString stringWithFormat:@"%@", [NSDate new]];
    [self.earthScreenModel downloadImagePackForPreviousDay:YES completion:^(NSArray *imagesArray) {
        self.epicImageryController.imageryArray = imagesArray;
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.epicImageryController updateImagery];
        });
    }];
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString * segueName = segue.identifier;
    if ([segueName isEqualToString: @"EPIC_images_controller_embed"]) {
        self.epicImageryController = (EPICImageryViewController *) [segue destinationViewController];
    }
}

@end
