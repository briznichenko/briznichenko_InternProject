//
//  EarthScreenEarthScreenProtocols.h
//  briznichenkoProject
//
//  Created by briznichenko on 04/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EarthScreenControllerProtocol <NSObject>

@optional
- (instancetype) initControllerWithData;

@end

@protocol EarthScreenViewControllerProtocol <NSObject>

-(void)setupViewControllerWithData:(NSData *)data;

@end

@protocol EarthScreenModelProtocol <NSObject>

@end
