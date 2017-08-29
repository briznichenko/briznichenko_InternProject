//
//  NearEarthEventDetailView.h
//  briznichenkoProject
//
//  Created by briznichenko on 23/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NearEarthEventDetailView : UIView 

@property (nonatomic, strong) UIImageView *eventImageView;
@property (nonatomic, strong) UILabel *eventImageDescriptionField;
@property (nonatomic, strong) UILabel *eventTitleField;
@property (nonatomic, strong) UILabel *eventDateField;
@property (nonatomic, strong) UIImageView *eventTypeIconImageView;
@property (nonatomic, strong) UILabel *eventTypeIconDescriptionField;
@property (nonatomic, strong) UITextView *eventDescriptionView;

-(instancetype)initAndInstallIntoSuperView:(UIView *) superview topY:(float) topY;

@end
