//
//  EarthScreenModel.h
//  briznichenkoProject
//
//  Created by briznichenko on 8/16/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EarthScreenModel : NSObject

@property (nonatomic, strong) NSArray *EPICImages;

@property (nonatomic, strong) NSDate *imageryDate;

- (instancetype) initWithData;
-(void)downloadImagePackForPreviousDay: (BOOL) direction completion:(void (^)(NSArray *imagesArray)) completion;

@end
