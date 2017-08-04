//
//  UIImage+UIImage_Filtering.m
//  briznichenkoProject
//
//  Created by briznichenko on 8/4/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "UIImage+Filtering.h"
#import <CoreImage/CoreImage.h>
#import <CoreGraphics/CoreGraphics.h>

@implementation UIImage (Filtering)

+ (NSArray *)makeFiltersForImage: (UIImage*) image
{
    UIImage *scaledImage = [UIImage imageWithCGImage:image.CGImage scale:0.1f orientation:UIImageOrientationUp];
    return @[[self makeSepiaFilteredImage: scaledImage],
             [self makeBloomFilteredImage:scaledImage],
             [self makeMonochromeFilteredImage:scaledImage],
             [self makeEdgesFilteredImage:scaledImage],
             [self makeSharpenedFilteredImage:scaledImage],
             [self makeNoirFilteredImage:scaledImage]];
}

+ (UIImage *)makeSepiaFilteredImage: (UIImage*) image
{
    CIImage *inputImage = [[CIImage alloc] initWithImage:image];
    CIFilter *sepiaFilter = [CIFilter filterWithName:@"CISepiaTone"];
    [sepiaFilter setValue:inputImage forKey:kCIInputImageKey];
    [sepiaFilter setValue: [NSNumber numberWithFloat:0.5f] forKey:kCIInputIntensityKey];
    CIImage *outputImage = [sepiaFilter valueForKey:kCIOutputImageKey];
    if(outputImage)
        return [UIImage imageWithCIImage:outputImage];
    NSLog(@"Failed to apply sepia filter!");
    return image;
}

+ (UIImage *)makeBloomFilteredImage: (UIImage*) image
{
    CIImage *inputImage = [[CIImage alloc] initWithImage:image];
    CIFilter *bloomFilter = [CIFilter filterWithName:@"CIBloom"];
    [bloomFilter setValue:inputImage forKey:kCIInputImageKey];
    [bloomFilter setValue: [NSNumber numberWithFloat:0.5f] forKey:kCIInputIntensityKey];
    CIImage *outputImage = [bloomFilter valueForKey:kCIOutputImageKey];
    if(outputImage)
        return [UIImage imageWithCIImage:outputImage];
    NSLog(@"Failed to apply Bloom filter!");
    return image;
}

+ (UIImage *)makeMonochromeFilteredImage: (UIImage*) image
{
    CIImage *inputImage = [[CIImage alloc] initWithImage:image];
    CIFilter *crystallizeFilter = [CIFilter filterWithName:@"CIColorMonochrome"];
    [crystallizeFilter setValue:inputImage forKey:kCIInputImageKey];
    [crystallizeFilter setValue: [NSNumber numberWithFloat:0.5f] forKey:kCIInputIntensityKey];
    CIImage *outputImage = [crystallizeFilter valueForKey:kCIOutputImageKey];
    if(outputImage)
        return [UIImage imageWithCIImage:outputImage];
    NSLog(@"Failed to apply monochrome filter!");
    return image;
}

+ (UIImage *)makeEdgesFilteredImage: (UIImage*) image
{
    CIImage *inputImage = [[CIImage alloc] initWithImage:image];
    CIFilter *monochromeFilter = [CIFilter filterWithName:@"CIEdges"];
    [monochromeFilter setValue:inputImage forKey:kCIInputImageKey];
    [monochromeFilter setValue: [NSNumber numberWithFloat:0.5f] forKey:kCIInputIntensityKey];
    CIImage *outputImage = [monochromeFilter valueForKey:kCIOutputImageKey];
    if(outputImage)
        return [UIImage imageWithCIImage:outputImage];
    NSLog(@"Failed to apply edges filter!");
    return image;
}

+ (UIImage *)makeSharpenedFilteredImage: (UIImage*) image
{
    CIImage *inputImage = [[CIImage alloc] initWithImage:image];
    CIFilter *noirFilter = [CIFilter filterWithName:@"CISharpenLuminance"];
    [noirFilter setValue:inputImage forKey:kCIInputImageKey];
    [noirFilter setValue: [NSNumber numberWithFloat:0.5f] forKey:kCIInputSharpnessKey];
    CIImage *outputImage = [noirFilter valueForKey:kCIOutputImageKey];
    if(outputImage)
        return [UIImage imageWithCIImage:outputImage];
    NSLog(@"Failed to apply sharpen filter!");
    return image;
}

+ (UIImage *)makeNoirFilteredImage: (UIImage*) image
{
    CIImage *inputImage = [[CIImage alloc] initWithImage:image];
    CIFilter *noirFilter = [CIFilter filterWithName:@"CIPhotoEffectNoir"];
    [noirFilter setValue:inputImage forKey:kCIInputImageKey];
    CIImage *outputImage = [noirFilter valueForKey:kCIOutputImageKey];
    if(outputImage)
        return [UIImage imageWithCIImage:outputImage];
    NSLog(@"Failed to apply noir filter!");
    return image;
}


@end
