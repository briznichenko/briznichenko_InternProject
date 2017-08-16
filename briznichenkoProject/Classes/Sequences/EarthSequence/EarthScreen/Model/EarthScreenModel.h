//
//  EarthScreenModel.h
//  briznichenkoProject
//
//  Created by briznichenko on 8/16/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EarthScreenModel : NSObject

@property (nonatomic, strong) NSArray *EPICImages;

- (instancetype) initWithData;

-(void) getEPICData:(void (^)(bool finished))completionBlock;
-(void)downloadNextImages:(void (^)(NSArray *imagesArray)) completion;
@end
