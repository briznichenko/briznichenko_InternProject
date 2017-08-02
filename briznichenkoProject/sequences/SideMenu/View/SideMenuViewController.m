//
//  SideMenuViewController.m
//  briznichenkoProject
//
//  Created by briznichenko on 25/07/2017.
//  Copyright © 2017 CHI. All rights reserved.
//

#import "SideMenuViewController.h"

@implementation SideMenuViewController
{
    NSArray *menuEntries;
}

#pragma mark - ViewController lifecycle methods

- (void)viewDidLoad {
	[super viewDidLoad];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    dispatch_async(dispatch_get_main_queue(),
    ^{
        self.sidemenuView.headerImage.layer.cornerRadius = self.sidemenuView.headerImage.frame.size.height / 2;
    });
}

-(void)setupViewControllerWithData:(NSData *)data
{
    self.sidemenuView = [[SideMenuView alloc] initAndInstallIntoSuperView: self.view];
    self.sidemenuView.headerImage.image = [UIImage imageWithData:data];
    self.sidemenuView.menuItems.delegate = self;
    self.sidemenuView.menuItems.dataSource = self;
    [self setupSideMenu];
    [self setupSideMenuActions];
}


#pragma mark - TableView methods

-(void) setupSideMenu
{
    menuEntries = [[NSArray alloc] initWithObjects:@"Galaxy Map", @"Earth Map", @"My Conditions", @"My Library", nil];
    self.view.backgroundColor = [UIColor colorWithWhite:0.01f alpha: 0.2f];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return menuEntries.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = @"ReuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    }
    cell.textLabel.text = menuEntries[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"%@", cell.textLabel.text);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -- Routing

-(void) setupSideMenuActions
{
    [self setupSwipeDetection];
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
    [self dismissViewControllerAnimated:YES completion:^{}];
}

@end
