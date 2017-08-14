//
//  ViewerViewerProtocols.h
//  briznichenkoProject
//
//  Created by briznichenko on 01/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ViewerControllerProtocol <NSObject>

@optional
- (instancetype) initControllerWithData;

@end

@protocol ViewerViewControllerProtocol <NSObject>

-(void)setupViewControllerWithData:(NSData *)data;

@end

@protocol ViewerModelProtocol <NSObject>

@end
