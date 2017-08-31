//
//  NearEarthObjectsView.h
//  briznichenkoProject
//
//  Created by briznichenko on 23/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NearEarthObjectsView : UIView 

@property (nonatomic, strong) UILabel *startDateLabel;
@property (nonatomic, strong) UILabel *endDateLabel;
@property (nonatomic, strong) UIButton *startDateChanger;
@property (nonatomic, strong) UIButton *endDateChanger;
@property (nonatomic, strong) UITableView *objectsTable;

-(instancetype)initAndInstallIntoSuperView:(UIView *) superview topY:(float) topY;

@end
