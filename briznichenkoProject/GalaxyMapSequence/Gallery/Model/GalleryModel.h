//
//  GalleryModel.h
//  briznichenkoProject
//
//  Created by briznichenko on 31/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GalleryProtocols.h"

@interface GalleryModel : NSObject
<GalleryModelProtocol>

@property (atomic, strong) NSData *data;

- (instancetype) initWithData;

@end
