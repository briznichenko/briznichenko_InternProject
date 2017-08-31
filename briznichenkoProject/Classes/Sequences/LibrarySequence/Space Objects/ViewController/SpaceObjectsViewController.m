//
//  SpaceObjectsViewController.m
//  briznichenkoProject
//
//  Created by briznichenko on 8/30/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "SpaceObjectsViewController.h"
#import "DescriptionController.h"
#import "CelestialBodyEntity.h"
#import "SpaceObjectCell.h"

@implementation SpaceObjectsViewController

static NSString *reuseID = @"space_object_cell";

#pragma mark -- ViewController lifecycle methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupViewController];
}

#pragma mark -- ViewController setup methods

- (void)setupViewController
{
    [self.spaceObjectsCollection registerNib:[UINib nibWithNibName:@"SpaceObjectCell" bundle:nil] forCellWithReuseIdentifier:reuseID];
}

-(void) setupModelWithData: (NSArray *)data
{
    self.spaceObjectsModel = [SpaceObjectsModel new];
    self.spaceObjectsModel.spaceObjects = data;
    [self.spaceObjectsModel formatEntities];
    [self.spaceObjectsCollection reloadData];
}

#pragma mark -- CollectionView delegate methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.spaceObjectsModel.spaceObjects.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SpaceObjectCell *cell = (SpaceObjectCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
    CelestialBodyEntity *entity = self.spaceObjectsModel.spaceObjects[indexPath.row];
    cell.spaceObjectNameLabel.text = entity.name;
    cell.spaceObjectImageView.image = [UIImage imageWithData:entity.image];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CelestialBodyEntity *entity = self.spaceObjectsModel.spaceObjects[indexPath.row];
    [self presentSpaceObjectDetailControllerWithEntity:entity];
}

#pragma mark -- Routing

- (void) presentSpaceObjectDetailControllerWithEntity: (CelestialBodyEntity *) entity
{
    self.descriptionController = [[DescriptionController alloc] initAndAssembleWithData: entity];
    self.descriptionController.descriptionViewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
//    self.descriptionController.objectImageURL = self.mapModel.descriptionImageURL;
    
    [self presentViewController:self.descriptionController.descriptionViewController animated:YES completion:^{}];
}


@end
