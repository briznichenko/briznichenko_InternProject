//
//  SplashView.m
//  briznichenkoProject
//
//  Created by briznichenko on 17/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "SplashView.h"

@implementation SplashView


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
    self.backgroundColor = [UIColor blackColor];
    [self makeSplashImageView];
    [self makeSplashLabel];
}

- (void) makeSplashImageView
{
    float borderWidth = 2.0f;
    
    self.splashImageView = [UIImageView new];
    self.splashImageView.clipsToBounds = YES;
    self.splashImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.splashImageView.layer.borderWidth = borderWidth;
    self.splashImageView.layer.borderColor = [UIColor blackColor].CGColor;
    [self addSubview:self.splashImageView];
}

- (void) makeSplashLabel
{
    self.splashLabel = [UILabel new];
    self.splashLabel.attributedText = [self getLabelAttributedText];
    [self addSubview:self.splashLabel];
}

-(NSAttributedString*) getLabelAttributedText
{
    NSString * welcomeString = @"Welcome!";
    
    float fontSize = 20.0f;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    paragraphStyle.lineSpacing = fontSize/2;
    UIFont * labelFont = [UIFont fontWithName:@"Helvetica-Light" size:fontSize];
    UIColor * labelColor = [UIColor colorWithWhite:1 alpha:1];
    NSShadow *shadow = [[NSShadow alloc] init];
    [shadow setShadowColor : [UIColor blackColor]];
    [shadow setShadowOffset : CGSizeMake (1.0, 1.0)];
    [shadow setShadowBlurRadius : 1];

    return [[NSAttributedString alloc] initWithString : welcomeString
                                           attributes :
                                                    @{
                                                    NSParagraphStyleAttributeName : paragraphStyle,
                                                    NSKernAttributeName : @2.0,
                                                    NSFontAttributeName : labelFont,
                                                    NSForegroundColorAttributeName : labelColor,
                                                    NSShadowAttributeName : shadow
                                                    }];
}


- (void) makeInnerConstraints
{
    self.splashImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.splashLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:
     @[[self.splashImageView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
       [self.splashImageView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
       [self.splashImageView.widthAnchor constraintEqualToAnchor:self.widthAnchor],
       [self.splashImageView.heightAnchor constraintEqualToAnchor:self.splashImageView.widthAnchor],
       
       [self.splashLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
       [self.splashLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor]
       ]];
    self.splashImageView.layer.cornerRadius = self.splashImageView.frame.size.width/2;
}

- (void) makeOuterConstraints:(UIView *) superview
{
    [superview addSubview:self];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:
     @[[self.centerXAnchor constraintEqualToAnchor:superview.centerXAnchor],
       [self.centerYAnchor constraintEqualToAnchor:superview.centerYAnchor],
       [self.widthAnchor constraintEqualToAnchor:superview.widthAnchor],
       [self.heightAnchor constraintEqualToAnchor:superview.heightAnchor]
       ]];
}

@end
