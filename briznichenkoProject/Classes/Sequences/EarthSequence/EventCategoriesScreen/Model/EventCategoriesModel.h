//
//  EventCategoriesModel.h
//  briznichenkoProject
//
//  Created by briznichenko on 8/18/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventCategoriesModel : NSObject

@property (nonatomic, strong) NSArray *eventCategories;

- (instancetype) initWithData;
- (void) getEventCategories:(void (^)(bool finished))completionBlock;
@end
