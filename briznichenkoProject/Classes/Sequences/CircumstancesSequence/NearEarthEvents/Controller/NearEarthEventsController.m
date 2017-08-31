//
//  NearEarthEventsController.m
//  briznichenkoProject
//
//  Created by briznichenko on 23/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "NearEarthEventsController.h"
#import "NearEarthEventDetailController.h"

@implementation NearEarthEventsController

-(instancetype) initAndAssemble
{
	self = [super init];
	if(self)
	{
		self.nearEarthEventsViewController = [NearEarthEventsViewController new];
		self.nearEarthEventsModel = [[NearEarthEventsModel alloc] initWithData];
        [self setupViewControllerWithData:[NSData new]];
        [self subscribeToNotifications];
	}	
	return self;
}

-(void)setupViewControllerWithData:(NSData *)data
{
    [self.nearEarthEventsViewController setupViewControllerWithData:data];
    [self.nearEarthEventsModel requestEventsHTML:^(NSString *htmlForEvents) {
        [self.nearEarthEventsViewController loadFormattedHTML: htmlForEvents];
    }];
}

#pragma mark -- Routing

- (void) subscribeToNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:@"requestNearEarthEventDetail"
                                               object:nil];
}

- (void) receiveNotification:(NSNotification *) notification
{
    if ([notification.name isEqualToString:@"requestNearEarthEventDetail"])
    {
        [self presentNearEarthEventWithURL: notification.object];
    }
}

- (void) presentNearEarthEventWithURL: (NSURL *) eventURL
{
    self.nearEarthEventDetailController = [[NearEarthEventDetailController alloc] initAndAssembleWithEventURL:eventURL orEntity: nil];
    [self.nearEarthEventsViewController.navigationController pushViewController:self.nearEarthEventDetailController.nearEarthEventDetailViewController animated:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
