//
//  EPICImageryViewController.m
//  briznichenkoProject
//
//  Created by briznichenko on 8/16/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "EPICImageryViewController.h"
#import "EarthScreenViewController.h"

@implementation EPICImageryViewController
{
    UIActivityIndicatorView *activityIndicator;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewController];
}

- (void)setupViewController
{
    activityIndicator = [UIActivityIndicatorView new];
    [self.view addSubview:activityIndicator];
    activityIndicator.center = self.imageryCollection.center;
    [self shouldHideActivityIndicator:NO];
    
    self.imageryArray = [NSMutableArray new];
    self.imageryCollection.delegate = self;
    self.imageryCollection.dataSource = self;
}
#pragma mark -- Collection View Delegate methods

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageryArray.count != 0 ? self.imageryArray.count : 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"epicImageCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithWhite:1.0f - (1.0f / indexPath.row) alpha:1.0f];
    if (self.imageryArray.count == 0)
        [self updateImagesArray];
    if(self.imageryArray.count > 0)
    {
        if (!activityIndicator.hidden)
            [self shouldHideActivityIndicator:YES];
        cell.backgroundView = [[UIImageView alloc] initWithImage:[self imageFromData: self.imageryArray[indexPath.row]]];
    }
    return cell;
}

#pragma mark -- Actions

- (void)shouldHideActivityIndicator:(BOOL) hideIndicator
{
    dispatch_async(dispatch_get_main_queue(), ^{
        hideIndicator? [activityIndicator stopAnimating] : [activityIndicator startAnimating];
        activityIndicator.hidden = hideIndicator;
    });
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"%ld", [self.imageryCollection indexPathForCell:self.imageryCollection.visibleCells.lastObject].row);
    if(self.imageryArray.count > 2)
        if ([self.imageryCollection indexPathForCell:self.imageryCollection.visibleCells.lastObject].row == (self.imageryArray.count - 2))
            [self updateImagesArray];
    
}

-(void ) updateImagesArray
{
    EarthScreenViewController *parentController = (EarthScreenViewController *)self.parentViewController;
    [self shouldHideActivityIndicator:NO];
    NSLog(@"Loading...");
    [parentController fetchImages];
}

#pragma mark - Util

- (UIImage *) imageFromData: (NSData *) data
{
    return [UIImage imageWithData:data];
}

@end
