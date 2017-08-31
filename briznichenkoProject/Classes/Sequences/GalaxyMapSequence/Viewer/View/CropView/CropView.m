//
//  CropView.m
//  briznichenkoProject
//
//  Created by briznichenko on 8/2/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "CropView.h"

@implementation CropView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, self.bounds);
    
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithRect:self.bounds];
    CGRect transparentFrame = self.transparentView.frame;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:transparentFrame cornerRadius:5.0f];
    [clipPath appendPath:path];

    clipPath.usesEvenOddFillRule = YES;
    [clipPath addClip];
    
    UIColor *tintColor = [UIColor blackColor];
    CGContextSetAlpha(context, 0.7f);
    
    [tintColor setFill];
    [clipPath fill];
}

@end
