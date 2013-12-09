//
//  SimpleMessageView.m
//  iosDummyKit
//
//  Created by ou on 2013/12/09.
//  Copyright (c) 2013年 Adore. All rights reserved.
//

#import "SimpleMessageView.h"

@implementation SimpleMessageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"SimpleMessage" owner:self options:nil];
        UIView *mainView = [subviewArray objectAtIndex:0];
        mainView.opaque = YES;
        [mainView setFrame:frame];
        [self addSubview:mainView];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

// =============================================================================
#pragma mark - Custom functions

// Set Message with Title
- (void)setMessage:(NSString *)msg title:(NSString *)title {
    [self setMessage:msg title:title center:NO];
}

// Set Message with Title
- (void)setMessage:(NSString *)msg title:(NSString *)title center:(BOOL)center {
    [self.messageLabel setText:msg];
    if (center) {
        self.messageLabel.textAlignment = NSTextAlignmentCenter;
    } else {
        self.messageLabel.numberOfLines = 0;
        [self.messageLabel sizeToFit];
    }
    if(title != nil) {
        [self.titleLabel setText:title];
    }
}


@end
