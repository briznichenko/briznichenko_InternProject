//
//  EarthScreenModel.h
//  briznichenkoProject
//
//  Created by briznichenko on 04/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EarthScreenProtocols.h"


@interface EarthScreenModel : NSObject
<EarthScreenModelProtocol>

@property (atomic, strong) NSData *data;

- (instancetype) initWithData;

@end
