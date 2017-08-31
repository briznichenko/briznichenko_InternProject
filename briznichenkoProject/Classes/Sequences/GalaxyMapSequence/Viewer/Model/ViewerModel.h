//
//  ViewerModel.h
//  briznichenkoProject
//
//  Created by briznichenko on 01/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewerProtocols.h"


@interface ViewerModel : NSObject
<ViewerModelProtocol>

@property (atomic, strong) NSData *data;

- (instancetype) initWithData;

@end
