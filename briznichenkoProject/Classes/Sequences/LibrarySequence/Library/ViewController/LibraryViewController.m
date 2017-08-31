//
//  LibraryViewController.m
//  briznichenkoProject
//
//  Created by briznichenko on 8/28/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "LibraryViewController.h"
#import "LibraryCell.h"

#import "EarthEventsViewController.h"
#import "SavedNearEarthEventsViewController.h"
#import "SavedNearEarthObjectsViewController.h"
#import "SpaceObjectsViewController.h"

@implementation LibraryViewController
{
    NSDictionary *libraryEntries;
    NSString *selectedEntry;
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
    NSString *entityName = [[cell.titleLabel.text stringByReplacingOccurrencesOfString:@" " withString:@""]
                            stringByReplacingOccurrencesOfString:@"s" withString:@""];
    NSArray *entites = [self.libraryModel.storedEntities valueForKey:entityName];
    cell.countLabel.text = [NSString stringWithFormat:@"%lu", entites.count];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LibraryCell *cell = (LibraryCell *)[collectionView cellForItemAtIndexPath:indexPath];
    selectedEntry = cell.titleLabel.text;
    NSString *segueID = [libraryEntries valueForKey:selectedEntry];
    [self performSegueWithIdentifier:segueID sender:self];
}

#pragma mark -- Routing

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *entityName;
    entityName = [[selectedEntry stringByReplacingOccurrencesOfString:@" " withString:@""]
                  stringByReplacingOccurrencesOfString:@"s" withString:@""];
    NSArray *entities = [self.libraryModel.storedEntities valueForKey:entityName];
    
    if ([segue.identifier isEqualToString: @"presentSpaceObjectsController"])
    {
        self.savedSpaceObjectsVC = (SpaceObjectsViewController *)segue.destinationViewController;
        [self.savedSpaceObjectsVC setupModelWithData:entities];
    }
    else if([segue.identifier isEqualToString:@"presentEarthEventsController"])
    {
        self.savedEarthEventsVC = (EarthEventsViewController *)segue.destinationViewController;
        [self.savedEarthEventsVC setupModelWithData:entities];
    }
    else if([segue.identifier isEqualToString:@"presentNearEarthObjectsController"])
    {
        self.savedNearEarthObjectsVC = (SavedNearEarthObjectsViewController *)segue.destinationViewController;
        [self.savedNearEarthObjectsVC setupModelWithData:entities];
    }
    else if([segue.identifier isEqualToString:@"presentNearEarthEventsController"])
    {
        self.savedNearEarthEventsVC = (SavedNearEarthEventsViewController *)segue.destinationViewController;
        [self.savedNearEarthEventsVC setupModelWithData:entities];
    }
}

@end
