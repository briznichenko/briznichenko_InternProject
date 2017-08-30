//
//  LibraryViewController.m
//  briznichenkoProject
//
//  Created by briznichenko on 8/28/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "LibraryViewController.h"
#import "LibraryCell.h"

@implementation LibraryViewController
{
    NSArray *libraryEntries;
    NSArray *segueIDs;
}

static NSString *reuseID = @"library_cell";

#pragma mark -- ViewController lifecycle methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupViewController];
}

#pragma mark -- ViewController setup methods

- (void)setupViewController
{
    self.libraryModel = [LibraryModel new];
    self.libraryCollection.delegate = self;
    self.libraryCollection.dataSource = self;
    
    UINib *libraryNib = [UINib nibWithNibName:@"LibraryCell" bundle:[NSBundle mainBundle]];
    [self.libraryCollection registerNib:libraryNib forCellWithReuseIdentifier:reuseID];
    [self.libraryCollection registerClass:[LibraryCell class] forCellWithReuseIdentifier:reuseID];
    libraryEntries = @[@"Space Objects", @"Earth Events", @"Near Earth Objects", @"Near Earth Events"];
    segueIDs = @[@"presentSpaceObjectsController",
                 @"presentEarthEventsController",
                 @"presentNearEarthObjectsController",
                 @"presentNearEarthEventsController"];
}

#pragma mark -- Collection View Delegate methods

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LibraryCell *cell = (LibraryCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithWhite:1.0f - (1.0f / indexPath.row) alpha:1.0f];
    cell.titleLabel.text = libraryEntries[indexPath.row];
    cell.countLabel.text = [NSString stringWithFormat:@"%lu", libraryEntries.count - indexPath.row];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LibraryCell *cell = (LibraryCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
    int index = (int)[libraryEntries indexOfObject:cell.titleLabel.text];
    [self performSegueWithIdentifier:segueIDs[index] sender:self];
}

#pragma mark -- Routing

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    if ([segue.identifier isEqualToString: @"EPIC_images_controller_embed"])
//        self.epicImageryController = (EPICImageryViewController *)segue.destinationViewController;
//    else if([segue.identifier isEqualToString:@"Flat_earth_view_controller_embed"])
//        self.flatEarthController = (FlatEarthViewController *)segue.destinationViewController;
//    else if([segue.identifier isEqualToString:@"present_event_categories"])
//        self.eventCategoriesController = (EventCategoriesController *)segue.destinationViewController;
}

@end
