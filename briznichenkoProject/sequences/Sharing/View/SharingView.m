//
//  SharingView.m
//  briznichenkoProject
//
//  Created by briznichenko on 09/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "SharingView.h"


@implementation SharingView
{
    NSArray *buttonSuperViews;
}


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
    [self makeButtons];
}

- (void) makeButtons
{
    self.facebookButton = [UIButton buttonWithType:UIButtonTypePlain];
    self.twitterButton = [UIButton buttonWithType:UIButtonTypePlain];
    self.googlePlusButton = [UIButton buttonWithType:UIButtonTypePlain];
    
    [self.facebookButton setTitle:@"FACEBOOK" forState:UIControlStateNormal];
    [self.twitterButton setTitle:@"TWITTER" forState:UIControlStateNormal];
    [self.googlePlusButton setTitle:@"GOOGLE PLUS" forState:UIControlStateNormal];
    
    NSArray *buttons = @[self.facebookButton, self.twitterButton, self.googlePlusButton];
    for(UIView *buttonView in buttons)
    {
        UIView *buttonSuperView = [UIView new];
        [buttonSuperView addSubview:buttonView];
        [self addSubview:buttonSuperView];
    }
    buttonSuperViews = self.subviews;
}

- (void) makeInnerConstraints
{
    float superviewWidthMultiplier = 1.0f / 3.0f;
    
    for (UIView *view in buttonSuperViews)
    {
        view.translatesAutoresizingMaskIntoConstraints = NO;
        if ([buttonSuperViews indexOfObject:view] == 0)
            [NSLayoutConstraint activateConstraints:
             @[[view.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
               [view.leftAnchor constraintEqualToAnchor:self.leftAnchor],
               [view.heightAnchor constraintEqualToAnchor:self.heightAnchor],
               [view.widthAnchor constraintEqualToAnchor:self.widthAnchor multiplier:superviewWidthMultiplier]]];
        else
        {
            UIView *previousView = buttonSuperViews[[buttonSuperViews indexOfObject:view] - 1];
            
            [NSLayoutConstraint activateConstraints:
             @[[view.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
               [view.leftAnchor constraintEqualToAnchor:previousView.rightAnchor],
               [view.heightAnchor constraintEqualToAnchor:self.heightAnchor],
               [view.widthAnchor constraintEqualToAnchor:self.widthAnchor multiplier:superviewWidthMultiplier]]];
        }
        view.subviews[0].translatesAutoresizingMaskIntoConstraints = NO;
        [NSLayoutConstraint activateConstraints:
        @[[view.subviews[0].centerYAnchor constraintEqualToAnchor:view.centerYAnchor],
          [view.subviews[0].centerXAnchor constraintEqualToAnchor:view.centerXAnchor]]];
    }
}

- (void) makeOuterConstraints:(UIView *) superview
{
	[superview addSubview:self];
    float widthMultiplier = 0.95f;
    float heightMultiplier = 0.2f;
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:
     @[[self.centerXAnchor constraintEqualToAnchor:superview.centerXAnchor],
       [self.centerYAnchor constraintEqualToAnchor:superview.centerYAnchor],
       [self.widthAnchor constraintEqualToAnchor:superview.widthAnchor multiplier: widthMultiplier],
       [self.heightAnchor constraintEqualToAnchor:superview.heightAnchor multiplier: heightMultiplier]
     ]];

}

@end
