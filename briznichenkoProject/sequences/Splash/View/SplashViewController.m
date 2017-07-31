//
//  SplashViewController.m
//  briznichenkoProject
//
//  Created by briznichenko on 17/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "SplashViewController.h"
#import "UIImage+animatedGIF.h"

@implementation SplashViewController

#pragma mark - ViewController lifecycle methods

- (void)viewDidLoad {
	[super viewDidLoad];
}

-(void)setupViewControllerWithData:(NSData *)data
{
    self.splashView = [[SplashView alloc] initAndInstallIntoSuperView: self.view];
    self.splashView.splashImageView.image = [UIImage animatedImageWithAnimatedGIFData:data];
}

@end
