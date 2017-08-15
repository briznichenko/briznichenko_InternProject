//
//  ViewerViewController.m
//  briznichenkoProject
//
//  Created by briznichenko on 01/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "ViewerViewController.h"
#import "UIImage+Filtering.h"
#import "CropView.h"

@implementation ViewerViewController
{
    void (^superposition)(void);
    NSDictionary *filtersDictionary;
    UIImage *initialImage;
}

#pragma mark - ViewController lifecycle methods

- (void) viewDidLoad {
	[super viewDidLoad];
    
    UIBarButtonItem *resetButton = [[UIBarButtonItem alloc] initWithTitle:@"Reset"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(dismissChanges)];
    self.navigationItem.rightBarButtonItem = resetButton;
    self.navigationItem.hidesBackButton = NO;
}

-(void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear:animated];
    [self makeFilterPreviews];
    initialImage = self.viewerView.viewedImageView.image;
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    CGSize contentSize = CGSizeMake(self.viewerView.filterBar.subviews[0].frame.size.width * (self.viewerView.filterBar.subviews.count - 1),
                                    self.viewerView.filterBar.frame.size.height);
    self.viewerView.filterBar.contentSize = contentSize;
    float navigationBarHeight = self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height;
    self.view.frame = CGRectMake(self.view.frame.origin.x,
                                 self.view.frame.origin.y + navigationBarHeight,
                                 self.view.frame.size.width,
                                 self.view.frame.size.height - navigationBarHeight);
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
    
    UITapGestureRecognizer *filterTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(filterTapGestureCaptured:)];
    filterTap.cancelsTouchesInView = NO;
    [self.viewerView.filterBar addGestureRecognizer:filterTap];
    
    UIPanGestureRecognizer *textFieldDragger = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveViewWithGestureRecognizer:)];
    [self.viewerView.addTextField addGestureRecognizer:textFieldDragger];
    
    UIPanGestureRecognizer *cropViewDragger = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveCropViewWithGestureRecognizer:)];
    [self.viewerView.cropViewOverlay addGestureRecognizer:cropViewDragger];
    
    UIPinchGestureRecognizer *cropViewResizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(resizeCropView:)];
    [self.viewerView.cropView addGestureRecognizer:cropViewResizer];
    
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

- (void) makeFilterPreviews
{
    for(UIView *subview in  self.viewerView.filterBar.subviews)
    {
        UIActivityIndicatorView *tempIndicator = [[UIActivityIndicatorView alloc] init];
        [subview addSubview: tempIndicator];
        tempIndicator.center = subview.center;
        [tempIndicator startAnimating];
    }
    
    [UIImage makeFiltersForImage:self.viewerView.viewedImageView.image completion:^(NSDictionary *filters) {
        filtersDictionary = filters;
        dispatch_async(dispatch_get_main_queue(), ^{
            for (UIImageView *filterView in self.viewerView.filterBar.subviews)
            {
                [filterView.subviews[0] removeFromSuperview];
                if([self.viewerView.filterBar.subviews indexOfObject:filterView] == filters.count)
                    break;
                filterView.image = filters.allValues[[self.viewerView.filterBar.subviews indexOfObject:filterView]];
                [self.viewerView.filterBar setNeedsDisplay];
            }
        });
    }];
}


#pragma mark ViewControllerActions

- (void) switchMode: (id) sender
{
    if([self.viewerView.modeSwitcher.titleLabel.text isEqualToString:@"✔"])
    {
        if(self.viewerView.cutButton.backgroundColor == [UIColor whiteColor])
            self.viewerView.viewedImageView.image = [self cropImage:self.viewerView.viewedImageView.image];
        else if (self.viewerView.filtersButton.backgroundColor == [UIColor whiteColor])
            self.viewerView.viewedImageView.image = [self applyFilterToImage:self.viewerView.viewedImageView.image];
        else if (self.viewerView.textButton.backgroundColor == [UIColor whiteColor])
            self.viewerView.viewedImageView.image = [self makeTextOnImage:self.viewerView.viewedImageView.image];
        
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
    [self saveImageToLibrary];
}

- (void) shareImage: (id) sender
{
    [self shareImage];
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

-(void) filterTapGestureCaptured: (UITapGestureRecognizer*) recognizer
{
    UIView* superview = recognizer.view;
    CGPoint subviewLocation = [recognizer locationInView:superview];
    UIImageView* subview = (UIImageView*)[superview hitTest:subviewLocation withEvent:nil];
    UIImage *image = subview.image;
    NSArray *filterNames = [filtersDictionary allKeysForObject:image];
    NSString *filterName = @"";
    
    if(filterNames[0])
        filterName = filterNames[0];
    
    UIActivityIndicatorView *filterIndicator = [[UIActivityIndicatorView alloc] init];
    [self.viewerView.viewedImageView addSubview: filterIndicator];
    filterIndicator.center = self.viewerView.viewedImageView.center;
    [filterIndicator startAnimating];
    
    if(filterName)
        dispatch_async(dispatch_get_main_queue(), ^{
            self.viewerView.viewedImageView.image = [UIImage makeFilteredImage:self.viewerView.viewedImageView.image withFilter: filterName];
            [filterIndicator stopAnimating];
            [filterIndicator removeFromSuperview];
        });
}

- (void) moveViewWithGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer
{
    CGPoint touchLocation = [panGestureRecognizer locationInView:self.viewerView.viewedImageView];
    
    self.viewerView.addTextField.center = touchLocation;
    
}

- (void) moveCropViewWithGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer
{
    CGPoint touchLocation = [panGestureRecognizer locationInView:self.viewerView.cropViewOverlay];
    
    self.viewerView.cropView.center = touchLocation;
    [self.viewerView.cropViewOverlay setNeedsDisplay];
}

- (void) resizeCropView:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    CGRect cropViewFrame = self.viewerView.cropView.frame;
    CGPoint cropViewCenter = self.viewerView.cropView.center;
    CGRect cropOverlayFrame = self.viewerView.cropViewOverlay.frame;
    float maxScale = 0.9f;
    float minScale = 0.25f;
    NSLog(@"%f", pinchGestureRecognizer.scale);
    if(cropViewFrame.size.width >= (cropOverlayFrame.size.width * minScale) && cropViewFrame.size.width <= cropOverlayFrame.size.width * maxScale)
        self.viewerView.cropView.frame = CGRectMake(cropViewFrame.origin.x,
                                                    cropViewFrame.origin.y,
                                                    cropViewFrame.size.width * pinchGestureRecognizer.scale,
                                                    cropViewFrame.size.height * pinchGestureRecognizer.scale);
    else if(cropViewFrame.size.width > cropOverlayFrame.size.width * maxScale)
        self.viewerView.cropView.frame = CGRectMake(cropOverlayFrame.origin.x,
                                                    cropOverlayFrame.origin.y,
                                                    cropOverlayFrame.size.width * maxScale,
                                                    cropOverlayFrame.size.height * maxScale);
    else if(cropViewFrame.size.width < (cropOverlayFrame.size.width * minScale))
        self.viewerView.cropView.frame = CGRectMake(cropOverlayFrame.origin.x,
                                                    cropOverlayFrame.origin.y,
                                                    cropOverlayFrame.size.width * minScale,
                                                    cropOverlayFrame.size.height *minScale);
    self.viewerView.cropView.center = cropViewCenter;
    [self.viewerView.cropViewOverlay setNeedsDisplay];
}
#pragma mark -- UIImage editing

- (void) saveImageToLibrary
{
    UIImageWriteToSavedPhotosAlbum(self.viewerView.viewedImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (UIImage *) cropImage: (UIImage *) originalImage
{
    CGSize imageSize = originalImage.size;
    float xRatio = imageSize.width / self.viewerView.cropViewOverlay.frame.size.width;
    float yRatio = imageSize.height / self.viewerView.cropViewOverlay.frame.size.height;
    CGRect clippedRect  = CGRectMake(self.viewerView.cropViewOverlay.transparentView.frame.origin.x * xRatio,
                                     self.viewerView.cropViewOverlay.transparentView.frame.origin.y * yRatio,
                                     self.viewerView.cropViewOverlay.transparentView.frame.size.width * xRatio,
                                     self.viewerView.cropViewOverlay.transparentView.frame.size.height * yRatio);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(originalImage.CGImage, clippedRect);
    UIImage *croppedImage   = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return croppedImage;
}

- (void) shareImage
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PresentSpaceObjectPhotoSharingController" object:nil];
}

- (UIImage *) applyFilterToImage: (UIImage *) originalImage
{
    UIImage *filteredImage = self.viewerView.viewedImageView.image;
    return filteredImage;
}

- (UIImage *) makeTextOnImage: (UIImage *) originalImage
{
    CGRect rect = CGRectMake(0,
                             0,
                             originalImage.size.width,
                             originalImage.size.height);
    UIGraphicsBeginImageContext(rect.size);
    [originalImage drawInRect:rect];
    
    UIFont* font = [UIFont fontWithName:@"Helvetica" size:(int)self.viewerView.textSizeSlider.value];
    
    NSMutableParagraphStyle* paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{ NSFontAttributeName: font,
                                  NSParagraphStyleAttributeName: paragraphStyle };
    
    CGSize imageSize = originalImage.size;
    CGRect textFrame = self.viewerView.addTextField.frame;
    float xRatio =  imageSize.width / self.viewerView.viewedImageView.frame.size.width;
    float yRatio = imageSize.height / self.viewerView.viewedImageView.frame.size.height;
    CGRect textRect = CGRectMake(textFrame.origin.x * xRatio,
                                 textFrame.origin.y * yRatio,
                                 textFrame.size.width,
                                 textFrame.size.height);

    [self.viewerView.addTextField.text drawInRect:textRect withAttributes:attributes];
    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    UIAlertController * savedAlert = [UIAlertController
                                      alertControllerWithTitle:@"Image saved"
                                      message:@"Image succesfully saved."
                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   [savedAlert dismissViewControllerAnimated:YES completion:^{}];
                               }];
    [savedAlert addAction:okButton];
    [self presentViewController:savedAlert animated:YES completion:nil];
}

- (void) dismissChanges
{
    self.viewerView.viewedImageView.image = initialImage;
}

@end
