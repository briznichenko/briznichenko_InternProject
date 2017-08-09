//
//  UIImage+UIImage_Filtering.h
//  briznichenkoProject
//
//  Created by briznichenko on 8/4/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Filtering)

+ (void)makeFiltersForImage: (UIImage*) image completion:(void (^) (NSArray *filteredArray, NSArray *filterNames)) completion;
+ (UIImage *)makeFilteredImage: (UIImage*) image withFilter: (NSString*) filterName;

@end
