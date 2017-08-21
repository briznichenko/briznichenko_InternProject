//
//  EventCategoriesCollectionController.m
//  briznichenkoProject
//
//  Created by briznichenko on 8/18/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "EventCategoriesController.h"
#import "EventsTableController.h"
#import "EventCell.h"

@interface EventCategoriesController ()

@end

@implementation EventCategoriesController
{
    NSArray *categories;
    int tag;
}

static NSString *reuseIdentifier = @"EventCategory";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewController];
}

- (void)setupViewController
{
    self.categoriesModel = [[EventCategoriesModel alloc] initWithData];
    [self.eventCategoriesCollection registerClass:[EventCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.eventCategoriesCollection.delegate = self;
    self.eventCategoriesCollection.dataSource = self;
    self.navigationItem.title = @"Event categories";
    self.navigationItem.titleView.tintColor = [UIColor whiteColor];
    [self.categoriesModel getEventCategories:^(bool finished) {
        categories = self.categoriesModel.eventCategories;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.eventCategoriesCollection reloadData];
        });
    }];
}


#pragma mark -- CollectionView delegate methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return categories? categories.count : 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EventCell *cell = (EventCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.eventNameLabel.text = [categories[indexPath.row] valueForKey:@"title"];
    cell.eventDescriptionView.text = [categories[indexPath.row] valueForKey:@"description"];
    
    cell.backgroundColor = indexPath.row % 2 ? [UIColor lightGrayColor] : [UIColor grayColor];
    
    cell.layer.borderColor = [UIColor blueColor].CGColor;
    cell.layer.borderWidth = 1.5f;
    
    cell.tag = [[categories[indexPath.row] valueForKey:@"id"] intValue];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"present_events_table" sender:self];
    tag = (int)[collectionView cellForItemAtIndexPath:indexPath].tag;
}

#pragma mark -- Routing

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"present_events_table"])
    {
        self.eventsTableController = (EventsTableController *)segue.destinationViewController;
        self.eventsTableController.tag = tag;
        NSLog(@"tag: %d", tag);
    }
}


@end
