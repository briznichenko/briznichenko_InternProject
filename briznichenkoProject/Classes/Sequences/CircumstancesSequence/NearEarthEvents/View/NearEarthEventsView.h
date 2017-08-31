//
//  NearEarthEventsView.h
//  briznichenkoProject
//
//  Created by briznichenko on 23/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NearEarthEventsView : UIView

@property (nonatomic, strong) UIWebView *eventsWebView;

-(instancetype)initAndInstallIntoSuperView:(UIView *) superview topY:(float) topY;

@end
