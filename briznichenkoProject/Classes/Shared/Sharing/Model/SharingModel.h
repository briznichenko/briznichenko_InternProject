//
//  SharingModel.h
//  briznichenkoProject
//
//  Created by briznichenko on 09/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SharingProtocols.h"


@interface SharingModel : NSObject
<SharingModelProtocol>

@property (atomic, strong) NSData *data;

- (instancetype) initWithData;

@end
