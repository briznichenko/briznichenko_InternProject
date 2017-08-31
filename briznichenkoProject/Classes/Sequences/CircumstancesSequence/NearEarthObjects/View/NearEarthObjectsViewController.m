//
//  NearEarthObjectsViewController.m
//  briznichenkoProject
//
//  Created by briznichenko on 23/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "NearEarthObjectsViewController.h"

@implementation NearEarthObjectsViewController

static NSString *reuseID = @"Nearby object cell";

#pragma mark - ViewController lifecycle methods

- (void)viewDidLoad {
	[super viewDidLoad];
}

#pragma mark - ViewController setup methods

-(void)setupViewControllerWithData:(NSData *)data
{
    float topY = [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.frame.size.height;
    self.nearEarthObjectsView = [[NearEarthObjectsView alloc] initAndInstallIntoSuperView: self.view topY: topY];
    [self.nearEarthObjectsView.objectsTable registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseID];
    self.nearEarthObjectsView.objectsTable.delegate = self;
    self.nearEarthObjectsView.objectsTable.dataSource = self;
}

#pragma mark - TableView delegate methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.nearEarthObjects? self.nearEarthObjects.count : 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *objects;
    if(self.nearEarthObjects.count > 1)
    {
        NSDictionary *objectsDict = [self.nearEarthObjects valueForKey:self.nearEarthObjects.allKeys[section]];
        objects = [objectsDict valueForKey:objectsDict.allKeys[0]];
    }
    else if (self.nearEarthObjects.count == 1)
        objects = [self.nearEarthObjects valueForKey:self.nearEarthObjects.allKeys[section]];
    return objects? objects.count : 0;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.nearEarthObjects.allKeys[section];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *objectCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseID];
    NSDictionary *currentObject;
    if(self.nearEarthObjects.count > 1)
    {
        NSArray *objects = [self.nearEarthObjects valueForKey:self.nearEarthObjects.allKeys[indexPath.section]];
        currentObject = objects[indexPath.row];
    }
    else
    {
        NSArray *objects = [self.nearEarthObjects valueForKey:self.nearEarthObjects.allKeys[indexPath.section]];
        currentObject = objects[indexPath.row];
    }
    objectCell.textLabel.text = [currentObject valueForKey:@"name"];
    NSString *distanceToEarth = [[[currentObject valueForKey:@"close_approach_data"]valueForKey:@"miss_distance"]valueForKey:@"kilometers"][0];
    objectCell.detailTextLabel.text = [NSString stringWithFormat:@"%i km", distanceToEarth.intValue];
    objectCell.backgroundColor = [UIColor colorWithWhite: indexPath.row % 2 ? 1.0f : 0.5f alpha:1.0f];
    return objectCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *currentObject;
    if(self.nearEarthObjects.count > 1)
    {
        NSArray *objects = [self.nearEarthObjects valueForKey:self.nearEarthObjects.allKeys[indexPath.section]];
        currentObject = objects[indexPath.row];
    }
    else
    {
        NSArray *objects = [self.nearEarthObjects valueForKey:self.nearEarthObjects.allKeys[indexPath.section]];
        currentObject = objects[indexPath.row];
    }
    NSString *objectID = [NSString stringWithFormat:@"%@", [currentObject valueForKey:@"neo_reference_id"]];
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"requestNearEarthObjectDetail"
     object: objectID];
}

@end
