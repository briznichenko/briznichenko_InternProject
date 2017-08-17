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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
