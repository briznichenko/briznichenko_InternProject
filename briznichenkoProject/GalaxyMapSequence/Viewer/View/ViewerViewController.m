//
//  ViewerViewController.m
//  briznichenkoProject
//
//  Created by briznichenko on 01/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "ViewerViewController.h"

@implementation ViewerViewController

#pragma mark - ViewController lifecycle methods

- (void)viewDidLoad {
	[super viewDidLoad];
}

-(void)setupViewControllerWithData:(NSData *)data
{
    self.viewerView = [[ViewerView alloc] initAndInstallIntoSuperView: self.view];
}

@end
