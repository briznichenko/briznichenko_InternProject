//
//  GalleryViewController.m
//  briznichenkoProject
//
//  Created by briznichenko on 31/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "GalleryViewController.h"
#import "CelestialBodyImageCell.h"

@implementation GalleryViewController

#pragma mark - ViewController lifecycle methods

- (void)viewDidLoad {
	[super viewDidLoad];
}

-(void)setupViewControllerWithData:(NSData *)data
{
    self.galleryView = [[GalleryView alloc] initAndInstallIntoSuperView: self.view];
    [self setupViewController];
}

- (void) setupViewController
{
    self.galleryView.imageryCollection.delegate = self;
    self.galleryView.imageryCollection.dataSource = self;
}

#pragma mark - UICollectionView delegate methods

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //stub
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"BodyImageCell";
    float borderWidth = 1.5f;
    UIColor *cellBorderColor = [UIColor orangeColor];
    
    CelestialBodyImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.layer.borderWidth = borderWidth;
    cell.layer.borderColor = cellBorderColor.CGColor;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Cell selected at: %li", (long)indexPath.row);
}


@end
