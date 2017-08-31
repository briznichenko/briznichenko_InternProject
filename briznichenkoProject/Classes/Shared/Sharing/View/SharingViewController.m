//
//  SharingViewController.m
//  briznichenkoProject
//
//  Created by briznichenko on 09/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <SafariServices/SafariServices.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import "SharingViewController.h"

@implementation SharingViewController
{
    UIImage *sharedImage;
}

#pragma mark - ViewController lifecycle methods

- (void)viewDidLoad {
	[super viewDidLoad];
}

-(void)setupViewControllerWithData:(NSData *)data
{
    self.sharingView = [[SharingView alloc] initAndInstallIntoSuperView: self.view];
    self.sharedImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.shareURLString]];
    sharedImage = [UIImage imageWithData:self.sharedImageData];
                            
    [self setupActions];
}

- (void) setupActions
{
    [self setupFacebookButton];
    [self setupTwitterButton];
    [self setupGoogleButton];
}

#pragma mark -- ViewController Actions

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    if ([touch view] == self.view)
        [self dismissViewControllerAnimated:YES completion:^{}];
}
#pragma mark -- FacebookSection

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
}

#pragma mark -- TwitterSection

- (void) setupTwitterButton
{
    UIButton *twitterShareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [twitterShareButton setTitle:@"Twitter \n share" forState:UIControlStateNormal];
    float rgbRatio = 1.0f / 255.0f;
    twitterShareButton.backgroundColor = [UIColor colorWithRed:29 * rgbRatio green: 202 * rgbRatio blue: 255 *rgbRatio alpha:1.0f];
    [twitterShareButton addTarget:self action:@selector(twitterLoginToCompose) forControlEvents:UIControlEventTouchUpInside];
    [self.sharingView.twitterPlaceholderView addSubview:twitterShareButton];
    twitterShareButton.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:
     @[[twitterShareButton.centerXAnchor constraintEqualToAnchor:self.sharingView.twitterPlaceholderView.centerXAnchor],
       [twitterShareButton.centerYAnchor constraintEqualToAnchor:self.sharingView.twitterPlaceholderView.centerYAnchor],
       [twitterShareButton.widthAnchor constraintEqualToAnchor:self.sharingView.twitterPlaceholderView.widthAnchor multiplier:0.5f],
       [twitterShareButton.heightAnchor constraintEqualToAnchor:self.sharingView.twitterPlaceholderView.heightAnchor multiplier:0.3f]]];
}

- (void) twitterLoginToCompose
{
    [[Twitter sharedInstance] logInWithCompletion:^(TWTRSession *session, NSError *error) {
        if (session) {
            [self presentTweetComposer];
        } else {
            NSLog(@"error: %@", [error localizedDescription]);
        }
    }];
}

- (void) presentTweetComposer
{
    NSString *tweetString = @"Check this amazing space object via <APPNAME>\n %@";
    NSString *tweetText = [NSString stringWithFormat:tweetString, [self.sharedText stringByReplacingOccurrencesOfString:@" " withString:@""]];
    NSString *message = [self makeTweetFromString:tweetText];
    if ([[Twitter sharedInstance].sessionStore hasLoggedInUsers]) {
        TWTRComposerViewController *composer = [[TWTRComposerViewController alloc] initWithInitialText:message image:sharedImage videoURL:nil];
        composer.delegate = self;
        [self presentViewController:composer animated:YES completion:nil];
    }
}

-(void)composerDidSucceed:(TWTRComposerViewController *)controller withTweet:(TWTRTweet *)tweet
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Tweet success"
                                                                   message:@"Your tweet was succesfully posted."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [controller presentViewController:alert animated:YES completion:^{
        [controller dismissViewControllerAnimated:YES completion:nil];
    }];
}

-(void)composerDidFail:(TWTRComposerViewController *)controller withError:(NSError *)error
{
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:@"Tweet failure"
                                message:[NSString stringWithFormat:@"Your tweet was not posted due to error: %@ \n Do you wish to try again?", error.localizedDescription]
                                preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"Yes, please."
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   TWTRComposerViewController *composer = [[TWTRComposerViewController alloc] initWithInitialText:self.sharedText image:sharedImage videoURL:nil];
                                   composer.delegate = self;
                                   [self presentViewController:composer animated:YES completion:nil];
                               }];
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"No, thanks."
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   [alert dismissViewControllerAnimated:YES completion:^{
                                       [controller dismissViewControllerAnimated:YES completion:nil];
                                   }];
                               }];
    [alert addAction:okButton];
    [alert addAction:noButton];
    
    [controller presentViewController:alert animated:YES completion:nil];
    
}

-(void)composerDidCancel:(TWTRComposerViewController *)controller
{
    NSLog(@"Tweet posting cancelled");
}

#pragma mark -- Google Section

- (void) setupGoogleButton
{
    UIButton *googleShareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [googleShareButton setTitle:@"Google+" forState:UIControlStateNormal];
    float rgbRatio = 1.0f / 255.0f;
    googleShareButton.backgroundColor = [UIColor colorWithRed:255 * rgbRatio green: 0 * rgbRatio blue: 0 *rgbRatio alpha:1.0f];
    [googleShareButton addTarget:self action:@selector(showGooglePlusShare) forControlEvents:UIControlEventTouchUpInside];
    [self.sharingView.googlePlaceholderView addSubview:googleShareButton];
    googleShareButton.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:
     @[[googleShareButton.centerXAnchor constraintEqualToAnchor:self.sharingView.googlePlaceholderView.centerXAnchor],
       [googleShareButton.centerYAnchor constraintEqualToAnchor:self.sharingView.googlePlaceholderView.centerYAnchor],
       [googleShareButton.widthAnchor constraintEqualToAnchor:self.sharingView.googlePlaceholderView.widthAnchor multiplier:0.6f],
       [googleShareButton.heightAnchor constraintEqualToAnchor:self.sharingView.googlePlaceholderView.heightAnchor multiplier:0.3f]]];
}

- (void) showGooglePlusShare
{
    NSURLComponents* urlComponents = [[NSURLComponents alloc]
                                      initWithString:@"https://plus.google.com/share"];
    urlComponents.queryItems = @[[[NSURLQueryItem alloc]
                                  initWithName:@"url"
                                  value:self.shareURLString]];
    NSURL* url = [urlComponents URL];
    SFSafariViewController* controller = [[SFSafariViewController alloc] initWithURL:url];
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark -- util

-(NSString *) makeTweetFromString: (NSString*) originalString
{
    NSString *tweetString = @"";
    NSArray *tweetComponents = [originalString componentsSeparatedByString:@"\n"];
    for(NSString *component in tweetComponents)
        if(![component containsString:@"~"])
            tweetString = [tweetString stringByAppendingString:[NSString stringWithFormat:@"\n%@", component]];
    return tweetString;
}

@end
