//
//  FlatEarthViewController.m
//  briznichenkoProject
//
//  Created by briznichenko on 8/17/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "FlatEarthViewController.h"

@interface FlatEarthViewController ()

@end

@implementation FlatEarthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupWebView];
}

- (void) setupWebView
{
    [self.flatEarthWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: @"https://worldview.earthdata.nasa.gov/"]]];
}

@end
