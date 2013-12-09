//
//  FirstViewController.m
//  iosDummyKit
//
//  Created by ou on 2013/12/06.
//  Copyright (c) 2013年 Adore. All rights reserved.
//

#import "LocalViewController.h"
#import "MyLibUtil.h"
#import "KGModal.h"
#import "SimpleMessageView.h"

#define KEY_TITLE   @"title"
#define KEY_TAG     @"tag"

@interface LocalViewController ()
    @property (nonatomic, strong) NSArray *menuItems;
@end

@implementation LocalViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.tabBarController.navigationItem.title = @"Local Utilities";
    
    self.menuItems = @[
       @{
           KEY_TITLE: NSLocalizedString(@"local.greeting", nil),
           KEY_TAG: @101,
           },
       @{
           KEY_TITLE: NSLocalizedString(@"local.modalPopup", nil),
           KEY_TAG: @102,
           }
       ];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// =============================================================================
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.menuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:CellIdentifier];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = [UIColor colorWithRed:51./255.
                                                   green:153./255.
                                                    blue:204./255.
                                                   alpha:1.0];
        cell.detailTextLabel.numberOfLines = 0;
    }
    
	NSDictionary *info = [self.menuItems objectAtIndex:indexPath.row];
    cell.textLabel.text = info[KEY_TITLE];
    
    return cell;
}

// =============================================================================
#pragma mark - UITableViewDelegate
/*
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70.0;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *item = self.menuItems[indexPath.row];
    int tag = [item[KEY_TAG] intValue];
    
    switch (tag) {
        case 101:
            [self sayHello];
            break;
        case 102:
            [self popupModalView];
            break;
        default:
            break;
    }
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)sayHello
{
    [MyLibUtil alert:[NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"Hello", nil),NSLocalizedString(@"World", nil)] title:nil];
}

- (void) popupModalView
{
    /*
    SimpleMessageView *messageView = [[SimpleMessageView alloc] initWithFrame:CGRectMake(0, 0, 280, 200)];
    
    [messageView setMessage:@"Hello World!\nこんにちは、世界！\n你好，世界！" title:NSLocalizedString(@"Welcome", nil)];
    //messageView.titleLabel.text = NSLocalizedString(@"Welcome", nil);
    //messageView.messageLabel.text = @"Hello World!\nこんにちは、世界！\n你好，世界！";
    
    [[KGModal sharedInstance] showWithContentView:messageView andAnimated:YES];
    */
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 200)];
    
    CGRect welcomeLabelRect = contentView.bounds;
    welcomeLabelRect.origin.y = 20;
    welcomeLabelRect.size.height = 20;
    UIFont *welcomeLabelFont = [UIFont boldSystemFontOfSize:17];
    UILabel *welcomeLabel = [[UILabel alloc] initWithFrame:welcomeLabelRect];
    welcomeLabel.text = @"Welcome to KGModal!";
    welcomeLabel.font = welcomeLabelFont;
    welcomeLabel.textColor = [UIColor whiteColor];
    welcomeLabel.textAlignment = NSTextAlignmentCenter;
    welcomeLabel.backgroundColor = [UIColor clearColor];
    welcomeLabel.shadowColor = [UIColor blackColor];
    welcomeLabel.shadowOffset = CGSizeMake(0, 1);
    [contentView addSubview:welcomeLabel];
    
    CGRect infoLabelRect = CGRectInset(contentView.bounds, 5, 5);
    infoLabelRect.origin.y = CGRectGetMaxY(welcomeLabelRect) + 5;
    infoLabelRect.size.height -= CGRectGetMinY(infoLabelRect);
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:infoLabelRect];
    infoLabel.text = @"KGModal is an easy drop in control that allows you to display any view "
    "in a modal popup. The modal will automatically scale to fit the content view "
    "and center it on screen with nice animations!";
    infoLabel.numberOfLines = 6;
    infoLabel.textColor = [UIColor whiteColor];
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.backgroundColor = [UIColor clearColor];
    infoLabel.shadowColor = [UIColor blackColor];
    infoLabel.shadowOffset = CGSizeMake(0, 1);
    [contentView addSubview:infoLabel];
    
    //[[KGModal sharedInstance] setCloseButtonLocation:KGModalCloseButtonLocationRight];
    [[KGModal sharedInstance] showWithContentView:contentView andAnimated:YES];
    
}

@end
