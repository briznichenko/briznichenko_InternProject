//
//  SavedNearEarthObjectsModel.h
//  briznichenkoProject
//
//  Created by briznichenko on 8/30/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SavedNearEarthObjectsModel : NSObject

@property (nonatomic, strong) NSArray *nearEarthObjects;

- (void) formatEntities;

@end
