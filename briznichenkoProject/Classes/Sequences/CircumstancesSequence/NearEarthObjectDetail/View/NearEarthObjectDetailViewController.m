//
//  NearEarthObjectDetailViewController.m
//  briznichenkoProject
//
//  Created by briznichenko on 23/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "NearEarthObjectDetailViewController.h"

@implementation NearEarthObjectDetailViewController

static NSString *orbitalInfoCellID =  @"orbital_info_cell";
static NSString *approachInfoCellID =  @"approach_info_cell";

#pragma mark - ViewController lifecycle methods

- (void)viewDidLoad {
	[super viewDidLoad];
}

-(void)viewDidLayoutSubviews
{
    self.navigationController.navigationBar.frame = CGRectMake(self.navigationController.navigationBar.frame.origin.x,
                                                               self.navigationController.navigationBar.frame.origin.y,
                                                               self.navigationController.navigationBar.frame.size.width,
                                                               44.0f);
    float cornerRadius = self.nearEarthObjectDetailView.frame.size.width / 6;
    self.nearEarthObjectDetailView.diameterSchemeView.layer.cornerRadius = cornerRadius;
    [self makeBarButtons];
    [super viewDidLayoutSubviews];
}

#pragma mark - ViewController setup methods

-(void)setupViewControllerWithData:(NSData *)data
{
    float topY = [UIApplication sharedApplication].statusBarFrame.size.height + 44.0f;
    self.nearEarthObjectDetailView = [[NearEarthObjectDetailView alloc] initAndInstallIntoSuperView: self.view topY: topY];
    
    self.nearEarthObjectDetailView.orbitalDataView.delegate = self;
    self.nearEarthObjectDetailView.orbitalDataView.dataSource = self;
    [self.nearEarthObjectDetailView.orbitalDataView registerClass:[UITableViewCell class] forCellReuseIdentifier:orbitalInfoCellID];
    
    self.nearEarthObjectDetailView.closeApproachDataView.delegate = self;
    self.nearEarthObjectDetailView.closeApproachDataView.dataSource = self;
    [self.nearEarthObjectDetailView.closeApproachDataView registerClass:[UITableViewCell class] forCellReuseIdentifier:approachInfoCellID];

    [self setupWithEntity];
}

- (void) setupWithEntity
{
    self.nearEarthObjectDetailView.objectNameLabel.text = self.objectEntity.name;
    self.nearEarthObjectDetailView.objectMagnitudeLabel.text = self.objectEntity.absolute_magnitude_h;
    self.nearEarthObjectDetailView.objectHazardousLabel.text = self.objectEntity.is_potentially_hazardous_asteroid;
    
    NSArray *diameterStrings = [self formatStringsFromEntity];
    
    self.nearEarthObjectDetailView.diameterKMLabel.text = diameterStrings[0];
    self.nearEarthObjectDetailView.diameterMeterLabel.text = diameterStrings[1];
    self.nearEarthObjectDetailView.diameterFeetLabel.text = diameterStrings[2];
    self.nearEarthObjectDetailView.diameterMilesLabel.text = diameterStrings[3];
    
    NSURL *requestURL = [NSURL URLWithString:self.objectEntity.nasa_jpl_url];
    [self.nearEarthObjectDetailView.objectNasaView loadRequest:[NSURLRequest requestWithURL:requestURL]];
}

- (void) makeBarButtons
{
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithTitle:@"Share"
                                                                     style:UIBarButtonItemStyleDone
                                                                    target:self
                                                                    action:@selector(shareObject)];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save"
                                                                      style:UIBarButtonItemStyleDone
                                                                     target:self
                                                                     action:@selector(saveObject)];
    self.navigationController.navigationBar.topItem.rightBarButtonItems = @[shareButton, saveButton];
}

#pragma mark - TableView delegate methods

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView == self.nearEarthObjectDetailView.orbitalDataView)
        return 1;
    else if(tableView == self.nearEarthObjectDetailView.closeApproachDataView)
        return self.objectEntity.close_approach_data.count - 1;
    return 0;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(tableView == self.nearEarthObjectDetailView.closeApproachDataView)
    {
        NSDictionary *approachData = self.objectEntity.close_approach_data[section];
        return [approachData valueForKey:@"close_approach_date"];
    }
    return @"";
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.nearEarthObjectDetailView.orbitalDataView)
        return self.objectEntity.orbital_data.count;
    else if(tableView == self.nearEarthObjectDetailView.closeApproachDataView)
    {
        NSDictionary *approachData = self.objectEntity.close_approach_data[section];
        return approachData.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.nearEarthObjectDetailView.orbitalDataView)
    {
        UITableViewCell *orbitalInfoCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:orbitalInfoCellID];
        orbitalInfoCell.textLabel.text = self.objectEntity.orbital_data.allKeys[indexPath.row];
        orbitalInfoCell.detailTextLabel.text =   [NSString stringWithFormat:@"%@", [self.objectEntity.orbital_data valueForKey:orbitalInfoCell.textLabel.text]];
        return orbitalInfoCell;
        
    }
    else if(tableView == self.nearEarthObjectDetailView.closeApproachDataView)
    {
        UITableViewCell *approachInfoCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:approachInfoCellID];
        NSDictionary *approachData = self.objectEntity.close_approach_data[indexPath.section];
        approachInfoCell.textLabel.text = approachData.allKeys[indexPath.row];
        approachInfoCell.detailTextLabel.text =   [NSString stringWithFormat:@"%@", [approachData valueForKey:approachInfoCell.textLabel.text]];
        return approachInfoCell;
    }
    return [UITableViewCell new];
}

#pragma mark - UIWebView delegate methods

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.nearEarthObjectDetailView.objectNasaView.scrollView setContentSize: CGSizeMake(self.nearEarthObjectDetailView.objectNasaView.frame.size.width,
                                                                                         self.nearEarthObjectDetailView.objectNasaView.scrollView.contentSize.height)];
    [self.nearEarthObjectDetailView.objectNasaView reload];
}

#pragma mark -- Messaging

- (void) saveObject
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"saveNearEarthObject" object:nil];
}

- (void) shareObject
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shareNearEarthObject" object:nil];
}

- (void) showSavedAlert
{
    UIAlertController * savedAlert = [UIAlertController
                                      alertControllerWithTitle:@"Object saved"
                                      message:@"Object succesfully saved."
                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   [savedAlert dismissViewControllerAnimated:YES completion:^{}];
                               }];
    [savedAlert addAction:okButton];
    [self presentViewController:savedAlert animated:YES completion:nil];
}


#pragma mark - Util

- (NSArray *) formatStringsFromEntity
{
    int diameterKM = ((int)[[self.objectEntity.estimated_diameter valueForKey:@"kilometers"] valueForKey:@"estimated_diameter_max"]
                      +  (int)[[self.objectEntity.estimated_diameter valueForKey:@"kilometers"] valueForKey:@"estimated_diameter_min"]) / 2;
    int diameterMeter = ((int)[[self.objectEntity.estimated_diameter valueForKey:@"meters"] valueForKey:@"estimated_diameter_max"]
                      +  (int)[[self.objectEntity.estimated_diameter valueForKey:@"meters"] valueForKey:@"estimated_diameter_min"]) / 2;
    int diameterFeet = ((int)[[self.objectEntity.estimated_diameter valueForKey:@"feet"] valueForKey:@"estimated_diameter_max"]
                      +  (int)[[self.objectEntity.estimated_diameter valueForKey:@"feet"] valueForKey:@"estimated_diameter_min"]) / 2;
    int diameterMiles = ((int)[[self.objectEntity.estimated_diameter valueForKey:@"miles"] valueForKey:@"estimated_diameter_max"]
                      +  (int)[[self.objectEntity.estimated_diameter valueForKey:@"miles"] valueForKey:@"estimated_diameter_min"]) / 2;
    NSString *diameterKMString = [NSString stringWithFormat:@"%i", diameterKM];
    NSString *diameterMeterString = [NSString stringWithFormat:@"%i", diameterMeter];
    NSString *diameterFeetString = [NSString stringWithFormat:@"%i", diameterFeet];
    NSString *diameterMilesString = [NSString stringWithFormat:@"%i", diameterMiles];
    return @[diameterKMString, diameterMeterString, diameterFeetString, diameterMilesString];
}

@end
