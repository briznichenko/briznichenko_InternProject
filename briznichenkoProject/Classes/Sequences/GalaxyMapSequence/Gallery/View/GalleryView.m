//
//  GalleryView.m
//  briznichenkoProject
//
//  Created by briznichenko on 31/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "GalleryView.h"
#import "CelestialBodyImageCell.h"
#import "CustomFlowLayout.h"


@implementation GalleryView


- (instancetype) initAndInstallIntoSuperView:(UIView *) superview
{
	self = [super init];
	if(self)
	{
		[self makeView];
		[self makeInnerConstraints];
		[self makeOuterConstraints: superview];
	}
	return self;
}

- (void) makeView
{
    self.backgroundColor = [UIColor whiteColor];
    [self makeImageryCollection];
}

-(void)makeImageryCollection
{
    CustomFlowLayout *imageryCollectionLayout = [[CustomFlowLayout alloc] init];
    imageryCollectionLayout.itemSize = CGSizeMake(120, 120);
    imageryCollectionLayout.minimumInteritemSpacing = 0;
    imageryCollectionLayout.minimumLineSpacing = 0;
    self.imageryCollection = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout: imageryCollectionLayout];
    self.imageryCollection.backgroundColor = [UIColor whiteColor];
    [self.imageryCollection registerClass:[CelestialBodyImageCell class] forCellWithReuseIdentifier:@"BodyImageCell"];
    
    [self addSubview:self.imageryCollection];
}

- (void) makeInnerConstraints
{
    self.imageryCollection.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:
     @[[self.imageryCollection.topAnchor constraintEqualToAnchor: self.topAnchor],
       [self.imageryCollection.centerXAnchor constraintEqualToAnchor: self.centerXAnchor],
       [self.imageryCollection.widthAnchor constraintEqualToAnchor: self.widthAnchor],
       [self.imageryCollection.heightAnchor constraintEqualToAnchor: self.heightAnchor]
       ]];
}

- (void) makeOuterConstraints:(UIView *) superview
{
	[superview addSubview:self];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:
     @[[self.centerXAnchor constraintEqualToAnchor:superview.centerXAnchor],
       [self.centerYAnchor constraintEqualToAnchor:superview.centerYAnchor],
       [self.widthAnchor constraintEqualToAnchor:superview.widthAnchor],
       [self.heightAnchor constraintEqualToAnchor:superview.heightAnchor]
     ]];

}

@end
