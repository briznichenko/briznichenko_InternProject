//
//  ViewerViewController.h
//  briznichenkoProject
//
//  Created by briznichenko on 01/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewerProtocols.h"
#import "ViewerView.h"

@interface ViewerViewController : UIViewController
<ViewerViewControllerProtocol, UIGestureRecognizerDelegate>

@property (nonatomic, strong) ViewerView* viewerView;

@end
