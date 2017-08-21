//
//  EventsTableController.m
//  briznichenkoProject
//
//  Created by briznichenko on 8/18/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "EventsTableController.h"
#import "EarthEventController.h"


@implementation EventsTableController
{
    NSArray *eventsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewController];
}

- (void)setupViewController
{
    self.eventsTableModel = [[EventsTableModel alloc] initWithData];
    self.eventsTable.delegate = self;
    self.eventsTable.dataSource = self;
    eventsArray = @[@{@"title" : @"Please wait", @"description" : @"Data is being fetched."}];
    [self.eventsTableModel getEventsForCategoryID:self.tag completion:^(bool finished) {
        if(finished)
        {
            eventsArray = self.eventsTableModel.events;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.eventsTable reloadData];
                [self.eventsTable setNeedsDisplay];
            });
        }
        else
        {
            eventsArray = @[@{@"title" : @"Empty", @"description" : @"No data for this category."}];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.eventsTable reloadData];
                [self.eventsTable setNeedsDisplay];
            });
        }
    }];
}

#pragma mark -- Table view delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return eventsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"event_cell"];
    cell.textLabel.text = [eventsArray[indexPath.row] valueForKey:@"title"];
    cell.detailTextLabel.text = [eventsArray[indexPath.row] valueForKey:@"description"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(eventsArray == self.eventsTableModel.events)
    {
        [self.eventsTableModel getEntityForIndex:(int)indexPath.row];
        [self performSegueWithIdentifier:@"present_event_screen" sender:self];
    }
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
}

#pragma mark -- Routing

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"present_event_screen"])
    {
        self.eventController = (EarthEventController *)segue.destinationViewController;
        self.eventController.eventEntity = self.eventsTableModel.entity;
        NSLog(@"%@", self.eventsTableModel.entity);
    }
}


@end
