//
//  GalleryViewController.m
//  briznichenkoProject
//
//  Created by briznichenko on 31/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "GalleryViewController.h"

@implementation GalleryViewController

#pragma mark - ViewController lifecycle methods

- (void)viewDidLoad {
	[super viewDidLoad];
}

-(void)setupViewControllerWithData:(NSData *)data
{
    self.galleryView = [[GalleryView alloc] initAndInstallIntoSuperView: self.view];
}

@end
