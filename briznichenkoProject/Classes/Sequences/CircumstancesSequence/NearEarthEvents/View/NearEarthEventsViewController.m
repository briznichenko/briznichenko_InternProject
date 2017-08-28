//
//  NearEarthEventsViewController.m
//  briznichenkoProject
//
//  Created by briznichenko on 23/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "NearEarthEventsViewController.h"

@implementation NearEarthEventsViewController
#pragma mark - ViewController lifecycle methods

- (void)viewDidLoad {
	[super viewDidLoad];
}

#pragma mark - ViewController setup methods

- (void) setupViewControllerWithData:(NSData *)data
{
    float topY = [UIApplication sharedApplication].statusBarFrame.size.height + 44.0f;
    self.nearEarthEventsView = [[NearEarthEventsView alloc] initAndInstallIntoSuperView: self.view topY:topY];
    self.nearEarthEventsView.eventsWebView.delegate = self;
}

-(void)loadFormattedHTML:(NSString *)stringHTML
{
    [self.nearEarthEventsView.eventsWebView loadHTMLString:stringHTML baseURL:[NSURL URLWithString:@"https://in-the-sky.org//newscal.php?day=1&skin=1"]];
}

#pragma mark - UIWebView delegate methods

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if(navigationType == UIWebViewNavigationTypeLinkClicked)
    {
        NSString *uri = request.URL.absoluteString;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"requestNearEarthEventDetail" object:request.URL];
        return NO;
    }
    return YES;
}

@end
