//
//  GalleryModel.m
//  briznichenkoProject
//
//  Created by briznichenko on 31/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "GalleryModel.h"


@implementation GalleryModel


- (instancetype) initWithData: (NSArray*) dataArray
{
	self = [super init];
	if(self)
	{
        [self fetchData: dataArray];
	}
	return self;
}

-(void) fetchData : (NSArray *) sourceArray
{
    self.data = [NSKeyedArchiver archivedDataWithRootObject:sourceArray];
}


@end
