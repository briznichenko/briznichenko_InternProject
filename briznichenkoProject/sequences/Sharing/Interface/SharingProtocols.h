//
//  SharingSharingProtocols.h
//  briznichenkoProject
//
//  Created by briznichenko on 09/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SharingControllerProtocol <NSObject>

@optional
- (instancetype) initControllerWithData;

@end

@protocol SharingViewControllerProtocol <NSObject>

-(void)setupViewControllerWithData:(NSData *)data;

@end

@protocol SharingModelProtocol <NSObject>

@end
