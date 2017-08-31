//
//  ViewController.m
//  briznichenkoProject
//
//  Created by briznichenko on 8/30/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "SavedNearEarthEventsViewController.h"
#import "NearEarthEventDetailController.h"
#import "NearEarthEventEntity.h"
#import "NearEarthEventCell.h"

@implementation SavedNearEarthEventsViewController

static NSString *reuseID = @"near_earth_event_cell";

#pragma mark -- ViewController lifecycle methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupViewController];
}

#pragma mark -- ViewController setup methods

- (void)setupViewController
{
    [self.nearEarthEventsCollection registerNib:[UINib nibWithNibName:@"NearEarthEventCell" bundle:nil] forCellWithReuseIdentifier:reuseID];
}

-(void) setupModelWithData: (NSArray *)data
{
    self.nearEarthEventsModel = [SavedNearEarthEventsModel new];
    self.nearEarthEventsModel.nearEarthEvents = data;
    [self.nearEarthEventsModel formatEntities];
    [self.nearEarthEventsCollection reloadData];
}

#pragma mark -- CollectionView delegate methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.nearEarthEventsModel.nearEarthEvents.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NearEarthEventCell *cell = (NearEarthEventCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
    NearEarthEventEntity *entity = self.nearEarthEventsModel.nearEarthEvents[indexPath.row];
    cell.eventName.text = entity.event_title;
    cell.eventImageView.image = [UIImage imageWithData:entity.event_image];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NearEarthEventEntity *entity = self.nearEarthEventsModel.nearEarthEvents[indexPath.row];
    [self presentNearEarthEventWithEntity:entity];
}

#pragma mark -- Routing

- (void) presentNearEarthEventWithEntity: (NearEarthEventEntity *) entity
{
    self.nearEarthEventDetailController = [[NearEarthEventDetailController alloc] initAndAssembleWithEventURL:nil orEntity: entity];
    [self.navigationController pushViewController:self.nearEarthEventDetailController.nearEarthEventDetailViewController animated:YES];
}

@end
