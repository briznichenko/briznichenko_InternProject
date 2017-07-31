//
//  DescriptionViewController.m
//  briznichenkoProject
//
//  Created by briznichenko on 31/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "DescriptionViewController.h"
#import "CelestialBodyEntity.h"

@implementation DescriptionViewController

#pragma mark - ViewController lifecycle methods

- (void)viewDidLoad {
	[super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.01f alpha: 0.2f];
    self.descriptionView.objectNameLabel.text = self.bodyEntity.bodyName;
}

-(void)setupViewControllerWithData:(NSData *)data
{
    self.descriptionView = [[DescriptionView alloc] initAndInstallIntoSuperView: self.view];
}


#pragma mark -- ViewController actions

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    if ([touch view] == self.view)
    {
        [self dismissViewControllerAnimated:YES completion:^{}];
    }
}

@end
