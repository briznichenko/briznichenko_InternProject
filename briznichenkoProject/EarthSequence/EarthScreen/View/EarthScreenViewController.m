//
//  EarthScreenViewController.m
//  briznichenkoProject
//
//  Created by briznichenko on 04/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "EarthScreenViewController.h"

@implementation EarthScreenViewController

#pragma mark - ViewController lifecycle methods

- (void)viewDidLoad {
	[super viewDidLoad];
}

-(void)setupViewControllerWithData:(NSData *)data
{
    self.earthscreenView = [[EarthScreenView alloc] initAndInstallIntoSuperView: self.view];
}

@end
