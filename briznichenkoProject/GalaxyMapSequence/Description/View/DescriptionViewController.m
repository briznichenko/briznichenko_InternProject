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
}

-(void)setupViewControllerWithData:(id)data
{
    self.bodyEntity = data;
    self.descriptionView = [[DescriptionView alloc] initAndInstallIntoSuperView: self.view];
    self.view.backgroundColor = [UIColor colorWithWhite:0.01f alpha: 0.2f];
    self.descriptionView.objectImageView.image = [UIImage imageWithData:self.bodyEntity.imageData];
    self.descriptionView.objectNameLabel.text = self.bodyEntity.bodyName;
    [self setupDescriptionViewWithInfo:self.bodyEntity.internalData];
    [self setupButtonActions];
}

-(void) setupDescriptionViewWithInfo: (NSDictionary*) info
{
    NSString *infoString = @"OBJECT INFO: \n";
    for (NSString * key in info.allKeys)
    {
        infoString = [[infoString stringByAppendingString: key] stringByAppendingString:[NSString stringWithFormat:@" %@ \n", [info valueForKey:key]]];
    }
    self.descriptionView.objectInfoView.text = infoString;
}

- (void) setupButtonActions
{
    [self.descriptionView.galleryButton addTarget:self action:@selector(presentGalleryController) forControlEvents:UIControlEventTouchUpInside];
    [self.descriptionView.saveButton addTarget:self action:@selector(saveObject) forControlEvents:UIControlEventTouchUpInside];
    [self.descriptionView.shareButton addTarget:self action:@selector(shareObject) forControlEvents:UIControlEventTouchUpInside];
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

-(void) presentGalleryController
{
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"presentGalleryController" object:nil];
    }];
}

- (void) saveObject
{
    NSLog(@"SAVE_OBJECT_STUB");
}

- (void) shareObject
{
    NSLog(@"SHARE_OBJECT_STUB");
}

@end
