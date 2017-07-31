//
//  DescriptionViewController.m
//  briznichenkoProject
//
//  Created by briznichenko on 31/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "DescriptionViewController.h"

@implementation DescriptionViewController

#pragma mark - ViewController lifecycle methods

- (void)viewDidLoad {
	[super viewDidLoad];
}

-(void)setupViewControllerWithData:(NSData *)data
{
    self.descriptionView = [[DescriptionView alloc] initAndInstallIntoSuperView: self.view];
}

@end
