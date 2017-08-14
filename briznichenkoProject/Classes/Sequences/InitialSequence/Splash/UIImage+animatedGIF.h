//
//  UIImage+UIImage___AnimatedGIF.h
//  briznichenkoProject
//
//  Created by briznichenko on 7/17/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImage (animatedGIF)

+ (UIImage * _Nullable)animatedImageWithAnimatedGIFData:(NSData * _Nonnull)theData;

+ (UIImage * _Nullable)animatedImageWithAnimatedGIFURL:(NSURL * _Nonnull)theURL;

@end
