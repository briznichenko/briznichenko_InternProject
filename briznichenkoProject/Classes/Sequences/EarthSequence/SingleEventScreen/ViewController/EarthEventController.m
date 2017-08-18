//
//  EarthEventController.m
//  briznichenkoProject
//
//  Created by briznichenko on 8/18/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "EarthEventController.h"

@interface EarthEventController ()

@end

@implementation EarthEventController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewController];
}

- (void) setupViewController
{
    self.eventTitleLabel.text = self.eventEntity.event_title;
    self.eventDescriptionLabel.text = self.eventEntity.event_description;
    [self.eventWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[self.eventEntity.event_sources[0] valueForKey:@"url"]]]];
}

#pragma mark -- Actions

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    if ([touch view] == self.view)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


@end
