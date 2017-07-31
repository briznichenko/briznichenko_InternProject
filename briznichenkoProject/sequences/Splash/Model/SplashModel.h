//
//  SplashModel.h
//  briznichenkoProject
//
//  Created by briznichenko on 17/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SplashModel : NSObject

@property (atomic, strong) NSData *data;

- (instancetype) initWithData;

@end
