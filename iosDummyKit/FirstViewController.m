//
//  FirstViewController.m
//  iosDummyKit
//
//  Created by ou on 2013/12/06.
//  Copyright (c) 2013年 Adore. All rights reserved.
//

#import "FirstViewController.h"
#import "MyLibUtil.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClickButton:(id)sender
{
    int tag= [sender tag];
    NSLog(@"Tag:%u", tag);
    switch (tag) {
        case 101:
            [MyLibUtil alert:[NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"Hello", @"word 1"),NSLocalizedString(@"World", @"word 2")] title:nil];
            break;
        default:
            break;
    }
}

@end
