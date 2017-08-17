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
    activityIndicator.center = self.view.center;
    [self shouldHideActivityIndicator:NO];
    
    self.imageryArray = [NSMutableArray new];
    self.imageryCollection.delegate = self;
    self.imageryCollection.dataSource = self;
}
#pragma mark -- Collection View Delegate methods

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageryArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"epicImageCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithWhite:1.0f - (1.0f / indexPath.row) alpha:1.0f];
    if(self.imageryArray.count == indexPath.row)
        [self updateImagesArray];
    if(self.imageryArray.count > 0)
        cell.backgroundView = [[UIImageView alloc] initWithImage:[self imageFromData: self.imageryArray[indexPath.row % 3]]];
    return cell;
}

#pragma mark -- Actions


-(void) updateImagery
{
    [self.imageryCollection reloadData];
    [self shouldHideActivityIndicator:YES];
}

- (void)shouldHideActivityIndicator:(BOOL) hideIndicator
{
    hideIndicator? [activityIndicator stopAnimating] : [activityIndicator startAnimating];
    activityIndicator.hidden = hideIndicator;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
   
}

-(void ) updateImagesArray
{
    EarthScreenViewController *parentController = (EarthScreenViewController *)self.parentViewController;
    [parentController fetchImages];
}

#pragma mark - Util

- (UIImage *) imageFromData: (NSData *) data
{
    return [UIImage imageWithData:data];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
