//
//  EarthEventController.m
//  briznichenkoProject
//
//  Created by briznichenko on 8/18/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "EarthEventController.h"
#import "SharingController.h"
#import "DataStorageManager.h"

@interface EarthEventController ()

@end

@implementation EarthEventController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewController];
}

- (void) setupViewController
{
    self.eventTitleLabel.text = self.eventEntity.event_title;
    self.eventDescriptionLabel.text = self.eventEntity.event_description;
    self.eventModel = [[EarthEventModel alloc] initWithData];
    NSLog(@"%@", [self.eventEntity.event_sources[0] valueForKey:@"url"]);
    self.eventWebView.delegate = self;
    [self.eventWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[self.eventEntity.event_sources[0] valueForKey:@"url"]]]];
}

#pragma mark -- Actions

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    if ([touch view] == self.view)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    long uriCheck =  [webView.request.URL.absoluteString rangeOfString:@"https://inciweb.nwcg.gov"].location;
    if(uriCheck)
    {
    NSString* script = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"EventDisplayScript"  ofType:nil] encoding:NSUTF8StringEncoding error:nil];
    [self.eventWebView stringByEvaluatingJavaScriptFromString:script]; 
    }
}


- (IBAction)saveButtonTapped:(id)sender
{
    [self saveEvent];
}
- (IBAction)shareButtonTapped:(id)sender
{
    [self presentSharingController];
}

#pragma mark -- Routing

- (void)presentSharingController
{
    self.sharingController = [[SharingController alloc] initAndAssembleWithShareURL:@"nil"];
    self.sharingController.sharingViewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:self.sharingController.sharingViewController animated:YES completion:nil];
}

- (void)saveEvent
{
    self.eventModel.eventEntity = self.eventEntity;
    [self.eventModel saveEvent:^(BOOL saved) {
        if(saved)
            [self showSavedAlert];
    }];
}

- (void) showSavedAlert
{
    UIAlertController * savedAlert = [UIAlertController
                                      alertControllerWithTitle:@"Event saved"
                                      message:@"Event succesfully saved."
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

@end
