//
//  CustomFlowLayout.m
//  briznichenkoProject
//
//  Created by briznichenko on 7/31/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "CustomFlowLayout.h"

@implementation CustomFlowLayout

- (NSArray *) layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *layoutAttributes = [super layoutAttributesForElementsInRect:rect];
    
    for(int i = 1; i < [layoutAttributes count]; ++i) {
        UICollectionViewLayoutAttributes *currentLayoutAttributes = layoutAttributes[i];
        UICollectionViewLayoutAttributes *prevLayoutAttributes = layoutAttributes[i - 1];
        NSInteger maximumSpacing = 4;
        NSInteger origin = CGRectGetMaxX(prevLayoutAttributes.frame);
        
        if(origin + maximumSpacing + currentLayoutAttributes.frame.size.width < self.collectionViewContentSize.width) {
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = origin + maximumSpacing;
            currentLayoutAttributes.frame = frame;
        }
    }
    return layoutAttributes;
}

@end
