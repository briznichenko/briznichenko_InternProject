//
//  EarthEventsViewController.m
//  briznichenkoProject
//
//  Created by briznichenko on 8/30/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "EarthEventsViewController.h"
#import "EarthEventController.h"
#import "EarthEventEntity.h"

@implementation EarthEventsViewController

static NSString *reuseID = @"earth_event_cell";

#pragma mark -- ViewController lifecycle methods

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark -- ViewController setup methods

-(void) setupModelWithData: (NSArray *)data
{
    self.earthEventsModel = [EarthEventsModel new];
    self.earthEventsModel.earthEvents = data;
    [self.earthEventsModel formatEntities];
    [self.earthEventsTable reloadData];
}

#pragma mark -- Table view delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.earthEventsModel.earthEvents.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    EarthEventEntity *entity = self.earthEventsModel.earthEvents[indexPath.row];
    cell.textLabel.text = entity.event_title;
    cell.detailTextLabel.text = entity.event_description;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EarthEventEntity *entity = self.earthEventsModel.earthEvents[indexPath.row];
    [self presentEarthEventDetailControllerWithEntity:entity];
}

#pragma mark -- Routing

- (void) presentEarthEventDetailControllerWithEntity: (EarthEventEntity *) entity
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"EarthSequence" bundle:nil];
    self.earthEventController = (EarthEventController *)[storyboard instantiateViewControllerWithIdentifier:@"EarthEventController"];
    self.earthEventController.eventEntity = entity;
    self.earthEventController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:self.earthEventController animated:YES completion:nil];
}

@end
