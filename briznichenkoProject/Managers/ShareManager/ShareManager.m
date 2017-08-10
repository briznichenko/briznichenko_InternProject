//
//  ShareManager.m
//  briznichenkoProject
//
//  Created by briznichenko on 8/9/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "ShareManager.h"


@implementation ShareManager

#pragma mark -- Singleton Methods

+ (id)sharedManager
{
    static ShareManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (id) init
{
    if (self = [super init])
    {
        [self makeManager];
    }
    return self;
}

- (void) makeManager
{
    [self initTwitter];
}

- (void) initTwitter
{

}

@end
