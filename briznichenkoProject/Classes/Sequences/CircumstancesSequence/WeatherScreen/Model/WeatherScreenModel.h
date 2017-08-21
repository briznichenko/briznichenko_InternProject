//
//  WeatherScreenModel.h
//  briznichenkoProject
//
//  Created by briznichenko on 21/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherScreenProtocols.h"


@interface WeatherScreenModel : NSObject
<WeatherScreenModelProtocol>

@property (atomic, strong) NSData *data;

- (instancetype) initWithData;
-(void) getVisibleStars:(void (^)(bool finished))completionBlock;

@end
