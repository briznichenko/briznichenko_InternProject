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
    
    // Your transparent window. This is for reference, but set this either as a property of the class or some other way
    CGRect transparentFrame; //this is the frame of the hole
    // Add the transparent window
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:transparentFrame cornerRadius:5.0f];
    [clipPath appendPath:path];
    
    // NOTE: If you want to add more holes, simply create another UIBezierPath and call [clipPath appendPath:anotherPath];
    
    // This sets the algorithm used to determine what gets filled and what doesn't
    clipPath.usesEvenOddFillRule = YES;
    // Add the clipping to the graphics context
    [clipPath addClip];
    
    // set your color
    UIColor *tintColor = [UIColor greenColor];
    
    // (optional) set transparency alpha
    CGContextSetAlpha(context, 0.7f);
    // tell the color to be a fill color
    [tintColor setFill];
    // fill the path
    [clipPath fill];
}

@end
