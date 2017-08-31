//
//  EventsTableModel.h
//  briznichenkoProject
//
//  Created by briznichenko on 8/18/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EarthEventEntity.h"

@interface EventsTableModel : NSObject

@property (nonatomic, strong) NSArray *events;
@property (nonatomic, strong) EarthEventEntity *entity;

- (instancetype) initWithData;

-(void) getEventsForCategoryID: (int) category_id completion:(void (^)(bool finished))completionBlock;
-(void) getEntityForIndex: (int) event_index;

@end
