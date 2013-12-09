//
//  SimpleMessageView.h
//  iosDummyKit
//
//  Created by ou on 2013/12/09.
//  Copyright (c) 2013年 Adore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleMessageView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

- (void)setMessage:(NSString *)message title:(NSString *)title;
- (void)setMessage:(NSString *)message title:(NSString *)title center:(BOOL)center;

@end
