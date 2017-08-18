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
    [self setupSwitcher];
    self.dateLabel.text = [NSString stringWithFormat:@"%@", self.earthScreenModel.imageryDate];
}

- (void)setupSwitcher
{
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIFont boldSystemFontOfSize:17], NSFontAttributeName,
                                self.earthViewSwitcher.tintColor, NSForegroundColorAttributeName,
                                nil];
    [self.earthViewSwitcher setTitleTextAttributes:attributes forState:UIControlStateNormal];
    NSDictionary *highlightedAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    [self.earthViewSwitcher setTitleTextAttributes:highlightedAttributes forState:UIControlStateSelected];
}

-(void) fetchImages
{
    [self.earthScreenModel downloadImagePackForPreviousDay:YES completion:^(NSArray *imagesArray)
    {
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.dateLabel.text = [NSString stringWithFormat:@"%@", self.earthScreenModel.imageryDate];
        });
        [self.epicImageryController.imageryArray addObjectsFromArray:imagesArray];
        [self.epicImageryController shouldHideActivityIndicator:YES];
        NSLog(@"Loaded.");
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.epicImageryController.imageryCollection reloadData];
        });
    }];
}
- (IBAction)switchScrolling:(id)sender
{
    if(self.autoscrollButton.state != UIControlStateSelected)
    {
        self.autoscrollButton.selected = YES;
//        while(self.autoscrollButton.selected)
            [self.epicImageryController.imageryCollection scrollToItemAtIndexPath: [NSIndexPath indexPathForRow: self.epicImageryController.imageryArray.count - 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
}

- (IBAction)segmentedControlValueChanged:(id)sender
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.dateLabel.text = [self.dateLabel.text isEqualToString: [NSString stringWithFormat:@"%@", self.earthScreenModel.imageryDate]]? self.dateLabel.text : [NSString stringWithFormat:@"%@", [NSDate new]];
    });
    self.earthScreenViewContainer.hidden = self.earthScreenViewContainer.hidden? NO : YES;
    self.earthFlatViewContainer.hidden = self.earthFlatViewContainer.hidden? NO : YES;
}
- (IBAction)presentEvents:(id)sender
{
    [self performSegueWithIdentifier:@"present_event_categories" sender:self];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"EPIC_images_controller_embed"])
        self.epicImageryController = (EPICImageryViewController *)segue.destinationViewController;
    else if([segue.identifier isEqualToString:@"Flat_earth_view_controller_embed"])
        self.flatEarthController = (FlatEarthViewController *)segue.destinationViewController;
    else if([segue.identifier isEqualToString:@"present_event_categories"])
        self.eventCategoriesController = (EventCategoriesController *)segue.destinationViewController;
}

@end
