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
    self.descriptionView.objectNameLabel.text = self.bodyEntity.bodyName;
    [self setupDescriptionViewWithInfo:self.bodyEntity.internalData];
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

-(void) makeObjectImage: (NSData*) data
{
    dispatch_async(dispatch_get_main_queue(),
                   ^{
                       self.descriptionView.objectImageView.image = [UIImage imageWithData:data];
                   });
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
