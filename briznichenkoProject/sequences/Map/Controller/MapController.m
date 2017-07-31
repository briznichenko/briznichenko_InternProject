//
//  MapController.m
//  briznichenkoProject
//
//  Created by briznichenko on 18/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "MapController.h"

@implementation MapController

-(instancetype) initAndAssemble
{
	self = [super init];
	if(self)
	{
		self.mapViewController = [MapViewController new];
		self.mapModel = [[MapModel alloc] initModelWithData];
        [self setupViewControllerWithData:self.mapModel.data];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveNotification:)
                                                     name:@"celBodyEntityRequest"
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveNotification:)
                                                     name:@"gotCelestialData"
                                                   object:nil];
	}	
	return self;
}

-(void)setupViewControllerWithData:(NSData *)data
{
    [self.mapViewController setupViewControllerWithData:data];
}

-(void)getCelestialDataByRa:(float)ra Dec:(float)dec FOV:(float)fov
{
    [self.mapModel getCelestialDataByRa:ra Dec:dec FOV:fov];
}

# pragma mark -- Data routing

- (void) receiveNotification:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:@"celBodyEntityRequest"])
    {
        NSArray *receivedArray = notification.object;
        NSNumber *ra = receivedArray[0];
        NSNumber *dec = receivedArray[1];
        NSNumber *fov = receivedArray[2];
        [self getCelestialDataByRa: ra.floatValue
                                 Dec: dec.floatValue
                                 FOV: fov.floatValue];
    }
    else if ([[notification name] isEqualToString:@"gotCelestialData"])
    {
        self.mapViewController.celestialBodyData = notification.object;
        [self.mapViewController presentObjectPopup];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
