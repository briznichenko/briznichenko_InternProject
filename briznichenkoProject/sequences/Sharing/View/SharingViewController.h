//
//  SharingViewController.h
//  briznichenkoProject
//
//  Created by briznichenko on 09/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SafariServices/SafariServices.h>
#import "SharingProtocols.h"
#import "SharingView.h"

@interface SharingViewController : UIViewController
<SharingViewControllerProtocol, SFSafariViewControllerDelegate>

@property (nonatomic, strong) SharingView* sharingView;

@end
