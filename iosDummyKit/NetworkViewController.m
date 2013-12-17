//
//  SecondViewController.m
//  iosDummyKit
//
//  Created by ou on 2013/12/06.
//  Copyright (c) 2013年 Adore. All rights reserved.
//

#import "NetworkViewController.h"
#import "MyUtil.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "KGModal.h"
#import "SVProgressHUD.h"

#define KEY_TITLE   @"title"
#define KEY_TAG     @"tag"

@interface NetworkViewController ()
    @property (nonatomic, strong) NSArray *menuItems;
@end

@implementation NetworkViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"network.title", nil);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	//[self.tableView setContentInset:UIEdgeInsetsMake(20,0,0,0)];

    self.menuItems = @[
       @{
           KEY_TITLE: NSLocalizedString(@"network.getJSON", nil),
           KEY_TAG: @101,
           },
       @{
           KEY_TITLE: NSLocalizedString(@"network.uploadImage", nil),
           KEY_TAG: @102,
           },
       @{
           KEY_TITLE: NSLocalizedString(@"network.displayImage", nil),
           KEY_TAG: @103,
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
        /*
         cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
         cell.textLabel.textColor = [UIColor colorWithRed:51./255.
         green:153./255.
         blue:204./255.
         alpha:1.0];
         cell.detailTextLabel.numberOfLines = 0;
         */
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
            [self getJson];
            break;
        case 102:
            [self uploadImage];
            break;
        case 103:
            [self displayImage];
            break;
        default:
            break;
    }
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

// =============================================================================
#pragma mark - Network functions

- (void) getJson
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:@"http://earsea.com/otaq/dummy/json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"responseObject: %@", responseObject);
        NSDictionary *jsonDict = (NSDictionary *) responseObject;
        NSString *hi = [jsonDict objectForKey:@"hi"];
        [MyUtil alert:hi title:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void) uploadImage
{
    UIActionSheet *photoSourcePicker = [[UIActionSheet alloc] initWithTitle:nil
                                                                   delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil)
                                                     destructiveButtonTitle:nil
                                                          otherButtonTitles:	@"撮影",
                                        @"ライブラリから選択",
                                        nil,
                                        nil];
    
    [photoSourcePicker showInView:self.view];
    
    
}

- (void)actionSheet:(UIActionSheet *)modalView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	switch (buttonIndex)
	{
		case 0:
		{
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
                imagePicker.delegate = self;
                imagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
                imagePicker.allowsEditing = NO;
                [self presentViewController:imagePicker animated:YES completion:nil];
            }
            else {
                [MyUtil alert:@"この端末にカメラがありません" title:NSLocalizedString(@"Error", nil)];
            }
			break;
		}
		case 1:
		{
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
                imagePicker.delegate = self;
                imagePicker.allowsEditing = NO;
                [self presentViewController:imagePicker animated:YES completion:nil];
            }
            else {
                [MyUtil alert:@"この端末の写真ライブラリにアクセスできません" title:NSLocalizedString(@"Error", nil)];
            }
			break;
		}
	}
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSData *image = UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerOriginalImage], 0.1);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSDictionary *parameters = @{@"from": @"mobile"};
    //NSURL *filePath = [NSURL fileURLWithPath:@"file://path/to/image.png"];
    [SVProgressHUD showWithStatus:@"アップロード中..." maskType:SVProgressHUDMaskTypeGradient];
    [manager POST:@"http://earsea.com/otaq/dummy/upload" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //[formData appendPartWithFileURL:filePath name:@"image" error:nil];
        [formData appendPartWithFileData:image name:@"file1" fileName:@"test.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD dismiss];
        //NSLog(@"Success: %@", responseObject);
        //[MyUtil alert:[NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"network.uploadImage", nil),NSLocalizedString(@"Success", nil)] title:NSLocalizedString(@"Success", nil)];
        [self displayImage];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD dismiss];
         NSLog(@"Error: %@", error);
        [MyUtil alert:[NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"network.uploadImage", nil),NSLocalizedString(@"Failed", nil)] title:NSLocalizedString(@"Error", nil)];
    }];
    
}

- (void)displayImage
{
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 320)];
    
    CGRect contentRect = contentView.bounds;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:contentRect];
    NSURL *imageURL = [NSURL URLWithString:@"http://earsea.com/otaq/files/test.jpg"];
    //[imageView setImageWithURL:imageURL placeholderImage:nil options:SDWebImageCacheMemoryOnly];
    [SVProgressHUD show];
    [imageView setImageWithURL:imageURL placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        [SVProgressHUD dismiss];
        if (error != nil) {
            [MyUtil alert:[NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"network.downloadImage", nil),NSLocalizedString(@"Failed", nil)] title:NSLocalizedString(@"Error", nil)];
        }
    }];
    [contentView addSubview:imageView];

    [[KGModal sharedInstance] showWithContentView:contentView andAnimated:YES];
    
}
@end
