//
//  EarthScreenViewController.m
//  briznichenkoProject
//
//  Created by briznichenko on 04/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "EarthScreenViewController.h"
#import "EPICImageryViewController.h"

@implementation EarthScreenViewController

#pragma mark - ViewController lifecycle methods

- (void)viewDidLoad {
	[super viewDidLoad];
}

-(void)setupViewControllerWithData:(NSData *)data
{
    self.earthScreenView = [[EarthScreenView alloc] initAndInstallIntoSuperView: self.view];
    self.imageryViewController = [EPICImageryViewController new];
    [self addChildViewController:self.imageryViewController];
    
    [self.earthScreenView.containerView addSubview: self.imageryViewController.view];
}

@end
