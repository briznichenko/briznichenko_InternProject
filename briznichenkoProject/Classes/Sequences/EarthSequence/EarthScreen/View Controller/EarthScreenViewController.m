//
//  EarthScreenViewController.m
//  briznichenkoProject
//
//  Created by briznichenko on 8/16/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "EarthScreenViewController.h"
#import "EPICImageryViewController.h"
#import "FlatEarthViewController.h"

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
}

-(void) fetchImages
{
    [self.earthScreenModel downloadImagePackForPreviousDay:YES completion:^(NSArray *imagesArray)
    {
        [self.epicImageryController.imageryArray addObjectsFromArray:imagesArray];
        [self.epicImageryController.imageryCollection reloadData];
    }];
}

- (IBAction)segmentedControlValueChanged:(id)sender
{
    self.earthScreenViewContainer.hidden = self.earthScreenViewContainer.hidden? NO : YES;
    self.earthFlatViewContainer.hidden = self.earthFlatViewContainer.hidden? NO : YES;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"EPIC_images_controller_embed"])
        self.epicImageryController = (EPICImageryViewController *)segue.destinationViewController;
    else if([segue.identifier isEqualToString:@"Flat_earth_view_controller_embed"])
        self.flatEarthController = (FlatEarthViewController *)segue.destinationViewController;
}

@end
