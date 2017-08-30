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
    NSDictionary *libraryEntries;
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
    [self.libraryModel fetchData:^(bool finished) {
        if(finished)
            [self.libraryCollection reloadData];
    }];
    self.libraryCollection.delegate = self;
    self.libraryCollection.dataSource = self;
    
    UINib *libraryCellNib = [UINib nibWithNibName:@"LibraryCell" bundle:nil];
    [self.libraryCollection registerNib:libraryCellNib forCellWithReuseIdentifier:reuseID];
    NSArray *cellTitles = @[@"Space Objects", @"Earth Events", @"Near Earth Objects", @"Near Earth Events"];
    NSArray *segueIDs = @[@"presentSpaceObjectsController",
                         @"presentEarthEventsController",
                         @"presentNearEarthObjectsController",
                         @"presentNearEarthEventsController"];
    libraryEntries = [NSDictionary dictionaryWithObjects:segueIDs forKeys:cellTitles];
}

#pragma mark -- Collection View Delegate methods

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LibraryCell *cell = (LibraryCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
    cell.titleLabel.text = libraryEntries.allKeys[indexPath.row];
    NSString *entityName = self.libraryModel.storedEntities.allKeys[indexPath.row];
    NSArray *entites = [self.libraryModel.storedEntities valueForKey:entityName];
    cell.countLabel.text = [NSString stringWithFormat:@"%lu", entites.count];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LibraryCell *cell = (LibraryCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSString *title = cell.titleLabel.text;
    NSString *segueID = [libraryEntries valueForKey:title];
    [self performSegueWithIdentifier:segueID sender:self];
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
