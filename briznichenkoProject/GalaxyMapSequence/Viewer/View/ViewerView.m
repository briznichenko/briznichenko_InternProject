//
//  ViewerView.m
//  briznichenkoProject
//
//  Created by briznichenko on 01/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "ViewerView.h"

@implementation ViewerView

- (instancetype) initAndInstallIntoSuperView:(UIView *) superview
{
	self = [super init];
	if(self)
	{
		[self makeView];
		[self makeInnerConstraints];
		[self makeOuterConstraints: superview];
        [self setupFilterConstraints];
	}
	return self;
}

- (void) makeView
{
    self.backgroundColor = [UIColor whiteColor];
    [self makeViewedImageView];
    [self makeBottomBar];
    [self makeModeSwitcher];
    [self makeEditingTools];
}

- (void) makeViewedImageView
{
    self.viewedImageView = [UIImageView new];
    self.viewedImageView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:self.viewedImageView];
}

- (void) makeModeSwitcher
{
    self.modeSwitcher = [UIButton buttonWithType:UIButtonTypePlain];
    [self.modeSwitcher setTitle:@"👁" forState:UIControlStateNormal];
    self.modeSwitcher.tintColor = [UIColor blueColor];
    
    [self addSubview:self.modeSwitcher];
}

- (void) makeBottomBar
{
    self.bottomBar = [UIView new];
    [self addSubview:self.bottomBar];
    
    for(UIView *barItem in [self makeAndAddButtons])
        [self.bottomBar addSubview: barItem];
}

-(NSArray*) makeAndAddButtons
{
    CGFloat buttonBorderWidth = 0.5f;
    CGColorRef borderColor = [UIColor blackColor].CGColor;
    
    self.shareButton = [UIButton buttonWithType: UIButtonTypePlain];
    [self.shareButton setTitle:@"↪️" forState:UIControlStateNormal];
    self.shareButton.layer.borderWidth = buttonBorderWidth;
    self.shareButton.layer.borderColor = borderColor;
    
    self.saveButton = [UIButton buttonWithType: UIButtonTypePlain];
    [self.saveButton setTitle:@"⬇️" forState:UIControlStateNormal];
    self.saveButton.layer.borderWidth = buttonBorderWidth;
    self.saveButton.layer.borderColor = borderColor;
    
    self.cutButton = [UIButton buttonWithType: UIButtonTypePlain];
    [self.cutButton setTitle:@"CUT" forState:UIControlStateNormal];
    self.cutButton.layer.borderWidth = buttonBorderWidth;
    self.cutButton.layer.borderColor = borderColor;
    self.cutButton.hidden = YES;
    
    self.filtersButton = [UIButton buttonWithType: UIButtonTypePlain];
    [self.filtersButton setTitle:@"FILTER" forState:UIControlStateNormal];
    self.filtersButton.layer.borderWidth = buttonBorderWidth;
    self.filtersButton.layer.borderColor = borderColor;
    self.filtersButton.hidden = YES;
    
    self.textButton = [UIButton buttonWithType: UIButtonTypePlain];
    [self.textButton setTitle:@"TEXT" forState:UIControlStateNormal];
    self.textButton.layer.borderWidth = buttonBorderWidth;
    self.textButton.layer.borderColor = borderColor;
    self.textButton.hidden = YES;
    
    return @[self.shareButton, self.saveButton, self.cutButton, self.filtersButton, self.textButton];
}

-(void) makeEditingTools
{
    self.cropViewOverlay = [CropView new];
    self.cropView = [UIView new];
    self.cropViewOverlay.transparentView = self.cropView;
    self.cropViewOverlay.backgroundColor = [UIColor colorWithWhite:0.001f alpha:0.5f];
    self.cropViewOverlay.hidden = YES;
    [self.viewedImageView addSubview:self.cropViewOverlay];
    [self.cropViewOverlay addSubview:self.cropView];
    
    self.filterBar = [UIScrollView new];
    self.filterBar.backgroundColor = [UIColor whiteColor];
    self.filterBar.bounces = NO;
    self.filterBar.hidden = YES;
    self.filterBar.userInteractionEnabled = YES;
    [self addSubview: self.filterBar];
    
    for (UIView *subview in [self makeFilters])
         [self.filterBar addSubview:subview];
    
    self.addTextField = [UITextField new];
    self.addTextField.text = @"SAMPLE TEXT";
    self.addTextField.font = [UIFont fontWithName:@"Helvetica" size:15];
    self.addTextField.hidden = YES;
    [self addSubview:self.addTextField];
    
    self.textSizeSlider = [UISlider new];
    self.textSizeSlider.continuous = NO;
    self.textSizeSlider.maximumValue = 50;
    self.textSizeSlider.minimumValue = 0;
    self.textSizeSlider.value = self.addTextField.font.pointSize;
    self.textSizeSlider.hidden = YES;
    self.textSizeSlider.maximumTrackTintColor = [UIColor blueColor];
    self.textSizeSlider.minimumTrackTintColor = [UIColor orangeColor];
    [self addSubview:self.textSizeSlider];
}

-(NSArray *) makeFilters
{
    NSMutableArray *filtersArray = [NSMutableArray new];
    for(int i = 0; i < 7; i++)
    {
        UIImageView *filterView = [UIImageView new];
        filterView.backgroundColor = [UIColor colorWithWhite: i / 10.0f alpha:1.0f];
        filterView.userInteractionEnabled = YES;
        [filtersArray addObject:filterView];
    }
    return filtersArray;
}

- (void) makeInnerConstraints
{
    float imageViewHeightMultiplier = 0.85f;
    float filterButtonWidthMultiplier = 1.0f / 3.0f;
    
    self.viewedImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.bottomBar.translatesAutoresizingMaskIntoConstraints = NO;
    self.modeSwitcher.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.shareButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.saveButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.cutButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.filtersButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.textButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.cropViewOverlay.translatesAutoresizingMaskIntoConstraints = NO;
    self.cropView.translatesAutoresizingMaskIntoConstraints = NO;
    self.filterBar.translatesAutoresizingMaskIntoConstraints = NO;
    self.addTextField.translatesAutoresizingMaskIntoConstraints = NO;
    self.textSizeSlider.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:
     @[[self.viewedImageView.topAnchor constraintEqualToAnchor:self.topAnchor],
       [self.viewedImageView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
       [self.viewedImageView.widthAnchor constraintEqualToAnchor:self.widthAnchor],
       [self.viewedImageView.heightAnchor constraintEqualToAnchor:self.heightAnchor multiplier:imageViewHeightMultiplier],
       
       [self.modeSwitcher.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
       [self.modeSwitcher.rightAnchor constraintEqualToAnchor:self.rightAnchor],
       
       [self.bottomBar.topAnchor constraintEqualToAnchor:self.viewedImageView.bottomAnchor],
       [self.bottomBar.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
       [self.bottomBar.widthAnchor constraintEqualToAnchor:self.widthAnchor],
       [self.bottomBar.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
       
       [self.shareButton.bottomAnchor constraintEqualToAnchor:self.bottomBar.bottomAnchor],
       [self.shareButton.leftAnchor constraintEqualToAnchor:self.bottomBar.leftAnchor],
       [self.shareButton.rightAnchor constraintEqualToAnchor:self.bottomBar.centerXAnchor],
       [self.shareButton.heightAnchor constraintEqualToAnchor:self.bottomBar.heightAnchor],
       
       [self.saveButton.bottomAnchor constraintEqualToAnchor:self.bottomBar.bottomAnchor],
       [self.saveButton.rightAnchor constraintEqualToAnchor:self.bottomBar.rightAnchor],
       [self.saveButton.leftAnchor constraintEqualToAnchor:self.bottomBar.centerXAnchor],
       [self.saveButton.heightAnchor constraintEqualToAnchor:self.bottomBar.heightAnchor],
       
       [self.filtersButton.centerYAnchor constraintEqualToAnchor:self.bottomBar.centerYAnchor],
       [self.filtersButton.centerXAnchor constraintEqualToAnchor:self.bottomBar.centerXAnchor],
       [self.filtersButton.heightAnchor constraintEqualToAnchor:self.bottomBar.heightAnchor],
       [self.filtersButton.widthAnchor constraintEqualToAnchor:self.bottomBar.widthAnchor multiplier:filterButtonWidthMultiplier],
       
       [self.cutButton.centerYAnchor constraintEqualToAnchor:self.bottomBar.centerYAnchor],
       [self.cutButton.leftAnchor constraintEqualToAnchor:self.bottomBar.leftAnchor],
       [self.cutButton.rightAnchor constraintEqualToAnchor:self.filtersButton.leftAnchor],
       [self.cutButton.heightAnchor constraintEqualToAnchor:self.bottomBar.heightAnchor],
       
       [self.textButton.centerYAnchor constraintEqualToAnchor:self.bottomBar.centerYAnchor],
       [self.textButton.rightAnchor constraintEqualToAnchor:self.bottomBar.rightAnchor],
       [self.textButton.leftAnchor constraintEqualToAnchor:self.filtersButton.rightAnchor],
       [self.textButton.heightAnchor constraintEqualToAnchor:self.bottomBar.heightAnchor],

       [self.cropViewOverlay.centerYAnchor constraintEqualToAnchor:self.viewedImageView.centerYAnchor],
       [self.cropViewOverlay.centerXAnchor constraintEqualToAnchor:self.viewedImageView.centerXAnchor],
       [self.cropViewOverlay.heightAnchor constraintEqualToAnchor:self.viewedImageView.heightAnchor],
       [self.cropViewOverlay.widthAnchor constraintEqualToAnchor:self.viewedImageView.widthAnchor],
       
       [self.cropView.centerYAnchor constraintEqualToAnchor:self.cropViewOverlay.centerYAnchor],
       [self.cropView.centerXAnchor constraintEqualToAnchor:self.cropViewOverlay.centerXAnchor],
       [self.cropView.heightAnchor constraintEqualToAnchor:self.cropViewOverlay.heightAnchor multiplier: 2.0 / 3.0f],
       [self.cropView.widthAnchor constraintEqualToAnchor:self.cropViewOverlay.widthAnchor multiplier: 2.0 / 3.0f],
       
       [self.filterBar.bottomAnchor constraintEqualToAnchor:self.bottomBar.topAnchor],
       [self.filterBar.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
       [self.filterBar.widthAnchor constraintEqualToAnchor:self.bottomBar.widthAnchor],
       [self.filterBar.heightAnchor constraintEqualToAnchor:self.bottomBar.heightAnchor multiplier: 2.0f / 3.0f],
       
       [self.addTextField.centerYAnchor constraintEqualToAnchor:self.viewedImageView.centerYAnchor],
       [self.addTextField.centerXAnchor constraintEqualToAnchor:self.viewedImageView.centerXAnchor],
       
       [self.textSizeSlider.bottomAnchor constraintEqualToAnchor:self.bottomBar.topAnchor],
       [self.textSizeSlider.centerXAnchor constraintEqualToAnchor:self.bottomBar.centerXAnchor],
       [self.textSizeSlider.widthAnchor constraintEqualToAnchor:self.bottomBar.widthAnchor multiplier: 0.9f]
       ]];
}

-(void) setupFilterConstraints
{
    for(int i = 0; i < self.filterBar.subviews.count; i++)
    {
        self.filterBar.subviews[i].translatesAutoresizingMaskIntoConstraints = NO;
        [NSLayoutConstraint activateConstraints:
         @[[self.filterBar.subviews[i].centerYAnchor constraintEqualToAnchor:self.filterBar.centerYAnchor],
           [self.filterBar.subviews[i].heightAnchor constraintEqualToAnchor:self.filterBar.heightAnchor],
           [self.filterBar.subviews[i].widthAnchor constraintEqualToAnchor:self.filterBar.widthAnchor multiplier:1.0 / 5.0f]
           ]];
        if (i == 0)
            [self.filterBar.subviews[i].leftAnchor constraintEqualToAnchor:self.filterBar.leftAnchor].active = YES;
        else
            [self.filterBar.subviews[i].leftAnchor constraintEqualToAnchor:self.filterBar.subviews[i - 1].rightAnchor].active = YES;
    }
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
