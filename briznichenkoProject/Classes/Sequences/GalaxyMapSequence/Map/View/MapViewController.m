//
//  MapViewController.m
//  briznichenkoProject
//
//  Created by briznichenko on 18/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "MapViewController.h"

@implementation MapViewController
{
    float currentZoom;
    CGPoint worldLocation;
    NSString *worldLocationString;
    CGPoint tapLocation;
}

#pragma mark - ViewController lifecycle methods

- (void)viewDidLoad {
	[super viewDidLoad];
    self.isReady = NO;
    currentZoom = 180.0f;
}

- (void) setupAndLoadMap:(NSString*) source
{
    [self.mapView.map loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:source]]];
    
    [self setupActions];
}

- (void)setupViewControllerWithData:(NSData *)data
{
    self.mapView = [[MapView alloc] initAndInstallIntoSuperView: self.view];
    self.mapView.map.delegate = self;
    self.mapView.map.scrollView.delegate = self;
    self.isReady = NO;
    [self setupAndLoadMap: [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]];
}


#pragma mark -- WebViewDelegateMethods

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"Space map has started loading.");
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"Space map has failed loading.");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"Space map is loaded.");
    self.isReady = YES;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return nil;
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if(self.isReady)
    {
        worldLocationString = [request.URL.absoluteString stringByReplacingCharactersInRange:NSMakeRange(0, [request.URL.absoluteString stringByDeletingLastPathComponent].length + 3) withString:@""];
        NSLog(@"Coords are: %@", worldLocationString);
        NSRange xRange = NSMakeRange(0, [worldLocationString rangeOfString:@","].location);
        NSRange yRange = NSMakeRange(xRange.length + 1, worldLocationString.length - xRange.length - 1);
        worldLocation.x = [worldLocationString substringWithRange:xRange].floatValue;
        worldLocation.y = [worldLocationString substringWithRange:yRange].floatValue;
        
        NSArray *arrayForEntityRequest = @[[NSNumber numberWithFloat: worldLocation.x],
                                           [NSNumber numberWithFloat: worldLocation.y],
                                           [NSNumber numberWithFloat: currentZoom]];
        
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"celBodyEntityRequest"
         object:arrayForEntityRequest];
    }

    return self.isReady ? NO : YES;
}

#pragma mark -- WebViewActions

-(void) presentObjectPopup
{
    if(!self.popupView)
    {
        self.popupView = [[PopupView alloc] initAndInstallIntoSuperView:self.mapView.map];
        [self.popupView.descriptionButton addTarget:self action:@selector(presentDescriptionController) forControlEvents: UIControlEventTouchUpInside];
        [self.popupView.galleryButton addTarget:self action:@selector(presentGalleryController) forControlEvents: UIControlEventTouchUpInside];
    }
    self.popupView.galleryButton.backgroundColor = [UIColor grayColor];
    self.popupView.galleryButton.userInteractionEnabled = NO;
    self.popupView.celestialBodyNameLabel.text = [self.celestialBodyData valueForKey:@"objName"];
    self.popupView.center = tapLocation;
    self.popupView.hidden = NO;
    self.popupView.celestialBodyRaDecLabel.text = worldLocationString;
}

- (void) setupActions
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
    tap.numberOfTapsRequired = 1;
    tap.delegate = self;
    [self.mapView.map addGestureRecognizer:tap];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didDoubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    doubleTap.delegate = self;
    [self.mapView.map addGestureRecognizer:doubleTap];
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(didPinch:)];
    pinch.delegate = self;
    [self.mapView.map addGestureRecognizer:pinch];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return YES;
}

-(void)didTap:(UITapGestureRecognizer *) recognizer
{
    if(recognizer.numberOfTapsRequired == 1)
    {
        if(self.popupView)
            self.popupView.hidden = YES;
    }
}

-(void)didDoubleTap:(UITapGestureRecognizer *) recognizer
{
    NSLog(@"Size of the native map: W%f, H%f", self.mapView.map.frame.size.width, self.mapView.map.frame.size.height);
    CGPoint touchPoint = [recognizer locationInView: self.mapView.map];
    tapLocation = touchPoint;
    NSLog(@"Location tapped in native map: X%f, Y%f", touchPoint.x, touchPoint.y);
    [self.mapView.map stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"window.location = aladin.pix2world(%f, %f);", touchPoint.x, touchPoint.y - 64]];
}

-(void)didPinch:(UIPinchGestureRecognizer *) recognizer
{
    currentZoom = currentZoom > 180 ? 180 : currentZoom / recognizer.scale;
        
    NSLog(@"Pinching! %f", currentZoom);
    [self.mapView.map stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"aladin.setFov(%f);", currentZoom]];
}

#pragma mark -- Routing

-(void) presentDescriptionController
{
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"presentDescriptionController"
     object:nil];
}

-(void) presentGalleryController
{
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"presentGalleryController"
     object:nil];
}

@end
