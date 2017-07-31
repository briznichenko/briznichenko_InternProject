//
//  ObjectDescriptionDescriptionProtocols.h
//  briznichenkoProject
//
//  Created by briznichenko on 31/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DescriptionControllerProtocol <NSObject>

@optional
- (instancetype) initControllerWithData;

@end

@protocol DescriptionViewControllerProtocol <NSObject>

-(void)setupViewControllerWithData:(NSData *)data;

@end

@protocol DescriptionModelProtocol <NSObject>

@end
