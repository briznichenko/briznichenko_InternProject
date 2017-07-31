//
//  SplashProtocols.h
//  briznichenkoProject
//
//  Created by briznichenko on 7/18/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SplashControllerProtocol <NSObject>

@optional
- (instancetype) initControllerWithData;

@required
-(instancetype) initAndAssemble;

@end

@protocol SplashViewControllerProtocol <NSObject>

-(void)setupViewControllerWithData:(NSData *)data;

@end

@protocol SplashModelProtocol <NSObject>

@end
