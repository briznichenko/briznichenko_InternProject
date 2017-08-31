//
//  GalleryGalleryProtocols.h
//  briznichenkoProject
//
//  Created by briznichenko on 31/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GalleryControllerProtocol <NSObject>

@optional
- (instancetype) initControllerWithData;

@end

@protocol GalleryViewControllerProtocol <NSObject>

-(void)setupViewControllerWithData:(NSData *)data;

@end

@protocol GalleryModelProtocol <NSObject>

@end
