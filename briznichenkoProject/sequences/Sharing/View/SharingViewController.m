//
//  SharingViewController.m
//  briznichenkoProject
//
//  Created by briznichenko on 09/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "SharingViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

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
   [self setupFacebookButton];
}

#pragma mark -- ViewController Actions

- (void) setupFacebookButton
{
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    content.contentURL = [NSURL
                          URLWithString:self.shareURLString];
    FBSDKShareButton *shareButton = [[FBSDKShareButton alloc] init];
    shareButton.shareContent = content;
    [self.sharingView.facebookPlaceholderView addSubview:shareButton];
    shareButton.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:
  @[[shareButton.centerXAnchor constraintEqualToAnchor:self.sharingView.facebookPlaceholderView.centerXAnchor],
    [shareButton.centerYAnchor constraintEqualToAnchor:self.sharingView.facebookPlaceholderView.centerYAnchor]]];
    shareButton.center = self.sharingView.facebookPlaceholderView.center;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    if ([touch view] == self.view)
        [self dismissViewControllerAnimated:YES completion:^{}];
}


@end
