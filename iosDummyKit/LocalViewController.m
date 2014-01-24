//
//  FirstViewController.m
//  iosDummyKit
//
//  Created by ou on 2013/12/06.
//  Copyright (c) 2013年 Adore. All rights reserved.
//

#import "LocalViewController.h"
#import "MyUtil.h"
#import "KGModal.h"
#import "SimpleMessageView.h"

#define KEY_TITLE   @"title"
#define KEY_TAG     @"tag"

@interface LocalViewController ()
    @property (nonatomic, strong) NSArray *menuItems;
@end

@implementation LocalViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"local.title", nil);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	//[self.tableView setContentInset:UIEdgeInsetsMake(20,0,0,0)];
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.menuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        /*
        cell.textLabel.textColor = [UIColor colorWithRed:51./255.
                                                   green:153./255.
                                                    blue:204./255.
                                                   alpha:1.0];
         */
        //cell.detailTextLabel.numberOfLines = 0;
    }
    
    if(indexPath.section == 0) {
        NSDictionary *info = [self.menuItems objectAtIndex:indexPath.row];
        cell.textLabel.text = info[KEY_TITLE];
    }
    
    return cell;
}

/*
 - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
 
 return 70.0;
 }
 */

// =============================================================================
#pragma mark - UITableViewDelegate

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
    [MyUtil alert:[NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"Hello", nil),NSLocalizedString(@"World", nil)] title:nil];
}

- (void) popupModalView
{
    SimpleMessageView *messageView = [[SimpleMessageView alloc] initWithFrame:CGRectMake(0, 0, 280, 200)];
    
    [messageView setMessage:@"Hello World!\nこんにちは、世界！\n你好，世界！" title:NSLocalizedString(@"Welcome", nil)];
    
    [[KGModal sharedInstance] showWithContentView:messageView andAnimated:YES];
    
}

@end
