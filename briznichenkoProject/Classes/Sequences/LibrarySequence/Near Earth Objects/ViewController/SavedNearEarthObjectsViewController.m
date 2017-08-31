//
//  SavedNearEarthObjectsViewController.m
//  briznichenkoProject
//
//  Created by briznichenko on 8/30/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "SavedNearEarthObjectsViewController.h"
#import "NearEarthObjectDetailController.h"
#import "NearEarthObjectEntity.h"

@implementation SavedNearEarthObjectsViewController

static NSString *reuseID = @"near_earth_object_cell";

#pragma mark -- ViewController lifecycle methods

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark -- ViewController setup methods

-(void) setupModelWithData: (NSArray *)data
{
    self.nearEarthObjectsModel = [SavedNearEarthObjectsModel new];
    self.nearEarthObjectsModel.nearEarthObjects = data;
    [self.nearEarthObjectsModel formatEntities];
    [self.nearEarthObjectsTable reloadData];
}

#pragma mark -- Table view delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.nearEarthObjectsModel.nearEarthObjects.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    NearEarthObjectEntity *entity = self.nearEarthObjectsModel.nearEarthObjects[indexPath.row];
    cell.textLabel.text = entity.name;
    cell.detailTextLabel.text = @"";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NearEarthObjectEntity *entity = self.nearEarthObjectsModel.nearEarthObjects[indexPath.row];
    [self presentNearEarthObjectDetailControlllerWithEntity:entity];
}

#pragma mark -- Routing

- (void) presentNearEarthObjectDetailControlllerWithEntity: (NearEarthObjectEntity *) entity
{
    self.nearEarthObjectDetailController = [[NearEarthObjectDetailController alloc] initAndAssemble];
    self.nearEarthObjectDetailController.nearEarthObjectDetailModel.objectEntity = entity;
    [self.nearEarthObjectDetailController setupWithEntity];
    [self.navigationController pushViewController:self.nearEarthObjectDetailController.nearEarthObjectDetailViewController animated:YES];
}

@end
