//
//  SideMenuSideMenuProtocols.h
//  briznichenkoProject
//
//  Created by briznichenko on 25/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SideMenuControllerProtocol <NSObject>

@optional
- (instancetype) initControllerWithData;

@end

@protocol SideMenuViewControllerProtocol <NSObject>

-(void)setupViewControllerWithData:(NSData *)data;

@end

@protocol SideMenuModelProtocol <NSObject>

@end
