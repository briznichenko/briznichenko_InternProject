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

+ (void)makeFiltersForImage: (UIImage*) image completion:(void (^) (NSDictionary *filters)) completion
{
    NSArray *filterNames = @[@"CISepiaTone", @"CIBloom", @"CIColorMonochrome", @"CIEdges", @"CIPhotoEffectChrome", @"CIComicEffect", @"CIEdges"];
    UIImage *scaledImage = [self imageWithImage:image scaledToSize:CGSizeMake(image.size.width / 10, image.size.height / 10)];
    
    NSMutableDictionary *filters = [NSMutableDictionary new];
    
    __block int counter = (int)filterNames.count;
    for (NSString *filterName in filterNames)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [filters setValue:[self makeFilteredImage:scaledImage withFilter:filterName] forKey:filterName];
            NSLog(@"%d", --counter);
            if(counter == 0)
                completion(filters);
        });
    }
}

+ (UIImage *)makeFilteredImage: (UIImage*) image withFilter: (NSString*) filterName
{
    EAGLContext *openGLContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES3];
    CIContext *context = [CIContext contextWithEAGLContext:openGLContext];
    
    CIImage *inputImage = [[CIImage alloc] initWithImage:image];
    
    CIFilter *imageFilter = [CIFilter filterWithName: filterName];
    [imageFilter setValue:inputImage forKey:kCIInputImageKey];
    if([imageFilter.inputKeys containsObject:kCIInputIntensityKey])
        [imageFilter setValue: [NSNumber numberWithFloat:0.5f] forKey:kCIInputIntensityKey];
    CIImage *outputImage = [imageFilter valueForKey:kCIOutputImageKey];
    if(outputImage)
    {
        CGImageRef CGImageResult = [context createCGImage:outputImage fromRect:outputImage.extent];
        return [UIImage imageWithCGImage:CGImageResult];
    }

    NSLog(@"Failed to apply %@ filter!", filterName);
    return image;
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


@end
