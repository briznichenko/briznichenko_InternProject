//
//  NearEarthEventDetailViewController.m
//  briznichenkoProject
//
//  Created by briznichenko on 23/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "NearEarthEventDetailViewController.h"

@implementation NearEarthEventDetailViewController

#pragma mark - ViewController lifecycle methods

- (void)viewDidLoad {
	[super viewDidLoad];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self setupBarButtons];
}

#pragma mark - ViewController setup methods

-(void)setupViewControllerWithData:(NSData *)data
{
    float topY = [UIApplication sharedApplication].statusBarFrame.size.height + 44.0f;
    self.nearEarthEventDetailView = [[NearEarthEventDetailView alloc] initAndInstallIntoSuperView: self.view topY:topY];
    [self setupFromEntity];
}

- (void) setupFromEntity
{
    self.nearEarthEventDetailView.eventImageView.image = [UIImage imageWithData:self.eventEntity.event_image];
    self.nearEarthEventDetailView.eventImageDescriptionField.text = self.eventEntity.event_image_description;
    self.nearEarthEventDetailView.eventTitleField.text = self.eventEntity.event_title;
    self.nearEarthEventDetailView.eventDateField.text = self.eventEntity.event_date;
    self.nearEarthEventDetailView.eventTypeIconImageView.image = [UIImage imageWithData:self.eventEntity.event_type_icon];
    self.nearEarthEventDetailView.eventTypeIconDescriptionField.text = self.eventEntity.event_type_description;
    self.nearEarthEventDetailView.eventDescriptionView.text = self.eventEntity.event_description;
}

- (void) setupBarButtons
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

#pragma mark -- ViewController actions

- (void) saveObject
{
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"SaveNearEarthEventEntity" object:nil];
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

- (void) shareObject
{
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"PresentNearEarthEventSharingController" object:nil];
}

@end
