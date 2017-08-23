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

-(void)setupViewControllerWithData:(NSData *)data
{
    self.nearEarthEventDetailView = [[NearEarthEventDetailView alloc] initAndInstallIntoSuperView: self.view];
}

@end
