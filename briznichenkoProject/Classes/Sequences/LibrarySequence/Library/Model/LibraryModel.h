//
//  LibraryModel.h
//  briznichenkoProject
//
//  Created by briznichenko on 8/30/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LibraryModel : NSObject

@property (nonatomic, strong) NSDictionary *storedEntities;

-(void) fetchData:(void (^) (bool finished)) completionBlock;

@end
