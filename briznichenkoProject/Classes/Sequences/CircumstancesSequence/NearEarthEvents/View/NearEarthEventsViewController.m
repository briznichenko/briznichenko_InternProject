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

-(void)setupViewControllerWithData:(NSData *)data
{
    self.nearEarthEventsView = [[NearEarthEventsView alloc] initAndInstallIntoSuperView: self.view];
}

@end
