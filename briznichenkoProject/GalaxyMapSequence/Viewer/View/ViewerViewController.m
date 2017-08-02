//
//  ViewerViewController.m
//  briznichenkoProject
//
//  Created by briznichenko on 01/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "ViewerViewController.h"

@implementation ViewerViewController
{
    void (^superposition)(void);
}

#pragma mark - ViewController lifecycle methods

- (void) viewDidLoad {
	[super viewDidLoad];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    CGSize contentSize = CGSizeMake(self.viewerView.filterBar.subviews[0].frame.size.width * (self.viewerView.filterBar.subviews.count - 1),
                                    self.viewerView.filterBar.frame.size.height);
    self.viewerView.filterBar.contentSize = contentSize;
}

-(void)setupViewControllerWithData:(NSData *)data
{
    self.viewerView = [[ViewerView alloc] initAndInstallIntoSuperView: self.view];
    [self setupButtonActions];
    [self setupEditingTools];
}

- (void) setupButtonActions
{
    [self.viewerView.modeSwitcher addTarget:self action:@selector(switchMode:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.viewerView.saveButton addTarget:self action:@selector(saveImage:) forControlEvents:UIControlEventTouchUpInside];
    [self.viewerView.shareButton addTarget:self action:@selector(shareImage:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.viewerView.cutButton addTarget:self action:@selector(cutImage:) forControlEvents:UIControlEventTouchUpInside];
    [self.viewerView.filtersButton addTarget:self action:@selector(filterImage:) forControlEvents:UIControlEventTouchUpInside];
    [self.viewerView.textButton addTarget:self action:@selector(addTextToImage:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.viewerView.textSizeSlider addTarget:self action:@selector(adjustTextSize:) forControlEvents:UIControlEventValueChanged];
}

- (void) setupEditingTools
{
    superposition =
    ^{
        _viewerView.cropViewOverlay.hidden = YES;
        [_viewerView.cropViewOverlay setNeedsDisplay];
        _viewerView.filterBar.hidden = YES;
        _viewerView.addTextField.hidden = YES;
        _viewerView.textSizeSlider.hidden = YES;
        
        _viewerView.cutButton.backgroundColor = [UIColor whiteColor];
        _viewerView.filtersButton.backgroundColor = [UIColor whiteColor];
        _viewerView.textButton.backgroundColor = [UIColor whiteColor];
    };
}

#pragma mark ViewControllerActions

- (void) switchMode: (id) sender
{
    if([self.viewerView.modeSwitcher.titleLabel.text isEqualToString:@"✔"])
    {
        [self.viewerView.modeSwitcher setTitle:@"✎"forState: UIControlStateNormal];
        superposition();
    }
    else
    {
    [self.viewerView.modeSwitcher setTitle:[self.viewerView.modeSwitcher.titleLabel.text isEqualToString:@"👁"] ? @"✎" : @"👁" forState: UIControlStateNormal];
    for(UIView* subview in self.viewerView.bottomBar.subviews)
        subview.hidden = subview.isHidden ? NO : YES;
    [self finishEdtitingMode];
    }
}

- (void) saveImage: (id) sender
{
    NSLog(@"SAVE");
}

- (void) shareImage: (id) sender
{
    NSLog(@"SHARE");
}

- (void) cutImage: (id) sender
{
    [self switchCropMode];
}

- (void) filterImage: (id) sender
{
    [self switchFilterMode];
}

- (void) addTextToImage: (id) sender
{
    [self switchTextInputMode];
}

- (void) switchCropMode
{
    [self.viewerView.modeSwitcher setTitle:@"✔" forState: UIControlStateNormal];
    superposition();
    
    self.viewerView.cropViewOverlay.hidden = NO;
    self.viewerView.filtersButton.backgroundColor = [UIColor grayColor];
    self.viewerView.textButton.backgroundColor = [UIColor grayColor];
}

- (void) switchFilterMode
{
    [self.viewerView.modeSwitcher setTitle:@"✔" forState: UIControlStateNormal];
    superposition();
    
    self.viewerView.filterBar.hidden = NO;
    self.viewerView.cutButton.backgroundColor = [UIColor grayColor];
    self.viewerView.textButton.backgroundColor = [UIColor grayColor];
}

- (void) switchTextInputMode
{
    [self.viewerView.modeSwitcher setTitle:@"✔" forState: UIControlStateNormal];
    superposition();
    
    self.viewerView.addTextField.hidden = NO;
    self.viewerView.textSizeSlider.hidden = NO;
    self.viewerView.cutButton.backgroundColor = [UIColor grayColor];
    self.viewerView.filtersButton.backgroundColor = [UIColor grayColor];
}

-(void) adjustTextSize: (id) sender
{
    self.viewerView.addTextField.font = [UIFont fontWithName:@"Helvetica" size:(int)self.viewerView.textSizeSlider.value];
    self.viewerView.addTextField.adjustsFontSizeToFitWidth = YES;
}

- (void) finishEdtitingMode
{
    [self.viewerView.modeSwitcher.titleLabel.text isEqualToString:@"✎"] ?
    superposition() : ^{};
}

@end
