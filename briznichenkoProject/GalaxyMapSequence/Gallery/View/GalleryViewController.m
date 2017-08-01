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
{
    NSArray *imagesArray;
}

#pragma mark - ViewController lifecycle methods

- (void)viewDidLoad {
	[super viewDidLoad];
}

-(void)setupViewControllerWithData:(NSData *)data
{
    self.galleryView = [[GalleryView alloc] initAndInstallIntoSuperView: self.view];
    imagesArray = [NSKeyedUnarchiver unarchiveObjectWithData: data];
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
//    return self.imagesArray.count;
    return 10;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float width = self.galleryView.imageryCollection.frame.size.width / 2;
    float height = width * 1.5f;
    return CGSizeMake(width, height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"BodyImageCell";
    float borderWidth = 1.5f;
    UIColor *cellBorderColor = [UIColor orangeColor];
    
    CelestialBodyImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    cell.objectImageView.image = imagesArray[1];
    cell.layer.borderWidth = borderWidth;
    cell.layer.borderColor = cellBorderColor.CGColor;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Cell selected at: %li", (long)indexPath.row);
    CelestialBodyImageCell *cell = (CelestialBodyImageCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSData *imageData = UIImagePNGRepresentation(cell.objectImageView.image);
    [self presentViewerControllerWithImageData: imageData];
}

#pragma mark -- Routing

-(void) presentViewerControllerWithImageData: (NSData *) imageData
{
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"presentViewerController"
     object: imageData];
}


@end
