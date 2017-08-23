//
//  SideMenuViewController.m
//  briznichenkoProject
//
//  Created by briznichenko on 25/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "SideMenuViewController.h"
#import <CoreGraphics/CoreGraphics.h>

@implementation SideMenuViewController

#pragma mark - ViewController lifecycle methods

- (void)viewDidLoad {
	[super viewDidLoad];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.alpha = 0.0f;
}

-(void)viewDidAppear:(BOOL)animated
{
    self.view.alpha = 1.0f;
    CATransition *transition = [[CATransition alloc] init];
    transition.duration = 0.5;
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromLeft;
    [self.view.layer addAnimation:transition forKey:kCATransition];
    [super viewDidAppear:animated];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    dispatch_async(dispatch_get_main_queue(),
    ^{
        self.sidemenuView.roundImage.layer.cornerRadius = self.sidemenuView.roundImage.frame.size.height / 2;
    });
}

-(void)setupViewControllerWithData:(NSData *)data
{
    self.sidemenuView = [[SideMenuView alloc] initAndInstallIntoSuperView: self.view];
    self.sidemenuView.headerImage.image = [UIImage imageWithData:data];
    self.sidemenuView.roundImage.image = self.sidemenuView.headerImage.image;
    self.sidemenuView.menuItems.delegate = self;
    self.sidemenuView.menuItems.dataSource = self;
    [self setupSideMenu];
    [self setupSideMenuActions];
}


#pragma mark - TableView methods

-(void) setupSideMenu
{
    self.menuEntries = [[NSArray alloc] initWithObjects:@"Galaxy Map", @"Earth Map", @"My Conditions", @"My Library", nil];
    self.view.backgroundColor = [UIColor colorWithWhite:0.01f alpha: 0.2f];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menuEntries.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = @"ReuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    }
    cell.textLabel.text = self.menuEntries[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[NSNotificationCenter defaultCenter] postNotificationName: self.menuEntries[indexPath.row] object:nil];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -- Routing

-(void) setupSideMenuActions
{
    [self setupSwipeDetection];
    [self.sidemenuView.menuButton addTarget:self action:@selector(dismissSideMenu:) forControlEvents:UIControlEventTouchUpInside];
}

-(void) setupSwipeDetection
{
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismissSideMenu:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.view addGestureRecognizer:recognizer];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    if ([touch view] == self.view)
    {
        [self dismissSideMenu:nil];
    }
}

-(void) dismissSideMenu: (id) sender
{
    [self dismissViewControllerAnimated:NO completion:^{}];
}

@end
