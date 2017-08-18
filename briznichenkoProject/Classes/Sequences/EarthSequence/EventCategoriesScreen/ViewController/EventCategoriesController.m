//
//  EventCategoriesCollectionController.m
//  briznichenkoProject
//
//  Created by briznichenko on 8/18/17.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "EventCategoriesController.h"
#import "EventsTableController.h"

@interface EventCategoriesController ()

@end

@implementation EventCategoriesController
{
    NSArray *categories;
    int tag;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewController];
}

- (void)setupViewController
{
    self.categoriesModel = [[EventCategoriesModel alloc] initWithData];
    [self.categoriesModel getEventCategories:^(bool finished) {
        categories = self.categoriesModel.eventCategories;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.eventCategoriesCollection reloadData];
        });
    }];
    self.eventCategoriesCollection.delegate = self;
    self.eventCategoriesCollection.dataSource = self;
}


#pragma mark -- CollectionView delegate methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return categories? categories.count : 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EventCategory" forIndexPath:indexPath];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(cell.center.x,
                                                                    cell.center.y,
                                                                    cell.frame.size.width / 3,
                                                                    cell.frame.size.height / 2)];
    titleLabel.text = [categories[indexPath.row] valueForKey:@"title"];
    [cell addSubview:titleLabel];
    
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                          titleLabel.frame.origin.y + titleLabel.frame.size.height,
                                                                          cell.frame.size.width,
                                                                          cell.frame.size.height / 2)];
    descriptionLabel.text = [categories[indexPath.row] valueForKey:@"description"];
    [cell addSubview:descriptionLabel];
    
    NSLog(@"%@", categories[indexPath.row]);
    
    cell.tag = [[categories[indexPath.row] valueForKey:@"id"] intValue];
    
    cell.backgroundColor = [UIColor colorWithRed:1.0f / indexPath.row
                                           green:1.0f / indexPath.row
                                            blue:1.0f / indexPath.row
                                           alpha:1.0f];
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
