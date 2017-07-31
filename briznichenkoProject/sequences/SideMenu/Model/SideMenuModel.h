//
//  SideMenuModel.h
//  briznichenkoProject
//
//  Created by briznichenko on 25/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SideMenuProtocols.h"


@interface SideMenuModel : NSObject
<SideMenuModelProtocol>

- (instancetype) initWithParams;
-(void) getImageData:(void (^)(NSData * fetchedData))completionBlock;

@end
