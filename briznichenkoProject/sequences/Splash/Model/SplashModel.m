//
//  SplashModel.m
//  briznichenkoProject
//
//  Created by briznichenko on 17/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "SplashModel.h"

@implementation SplashModel

- (instancetype) initWithData
{
	self = [super init];
	if(self)
	{
        [self fetchData];
	}
	return self;
}

-(void) fetchData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"giphy" ofType:@"gif"];
    NSData *imageData = [NSData dataWithContentsOfFile:path];
    self.data = imageData;
}

@end
