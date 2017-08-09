//
//  SharingViewController.m
//  briznichenkoProject
//
//  Created by briznichenko on 09/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "SharingViewController.h"

@implementation SharingViewController

#pragma mark - ViewController lifecycle methods

- (void)viewDidLoad {
	[super viewDidLoad];
}

-(void)setupViewControllerWithData:(NSData *)data
{
    self.sharingView = [[SharingView alloc] initAndInstallIntoSuperView: self.view];
    [self setupActions];
}

- (void) setupActions
{
    [self.sharingView.twitterButton addTarget:self action:@selector(shareToTwitter) forControlEvents:UIControlEventTouchUpInside];
     [self.sharingView.facebookButton addTarget:self action:@selector(shareToFacebook) forControlEvents:UIControlEventTouchUpInside];
     [self.sharingView.twitterButton addTarget:self action:@selector(shareToGoogle) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark -- ViewController Actions

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    if ([touch view] == self.view)
    {
        [self dismissViewControllerAnimated:YES completion:^{}];
    }
}

- (void) shareToTwitter
{
    NSLog(@"TWITTER");
}

- (void) shareToFacebook
{
    NSLog(@"FACEBOOK");
}

- (void) shareToGoogle
{
    NSLog(@"GOOGLE");
    NSURL *shareURL = [NSURL URLWithString: @"http://archive.eso.org/dss/dss/image?ra=00%2007%2010.4%20+&dec=8%2048%2014%20%20%20%20%20%20%20&equinox=J2000&name=&x=8&y=6&Sky-Survey=DSS1&mime-type=download-gif"];
    [self showGooglePlusShare: shareURL];
}

- (void)showGooglePlusShare:(NSURL*)shareURL
{
    NSURLComponents* urlComponents = [[NSURLComponents alloc] initWithString:@"https://plus.google.com/share"];
    urlComponents.queryItems = @[[[NSURLQueryItem alloc]
                                  initWithName:@"url"
                                  value:[shareURL absoluteString]]];
    NSURL* url = [urlComponents URL];
    NSLog(@"%@", url.absoluteString);
    
    SFSafariViewController* controller = [[SFSafariViewController alloc] initWithURL:url];
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
}

@end
