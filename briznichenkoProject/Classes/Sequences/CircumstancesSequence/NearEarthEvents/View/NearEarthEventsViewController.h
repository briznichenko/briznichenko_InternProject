//
//  NearEarthEventsViewController.h
//  briznichenkoProject
//
//  Created by briznichenko on 23/08/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearEarthEventsProtocols.h"
#import "NearEarthEventsView.h"

@interface NearEarthEventsViewController : UIViewController
<NearEarthEventsViewControllerProtocol, UIWebViewDelegate>

@property (nonatomic, strong) NearEarthEventsView* nearEarthEventsView;

- (void) loadFormattedHTML: (NSString *) stringHTML;

@end
