//
//  MyLibAlertView.m
//  MyLib
//
//  Created by ou on 2013/12/06.
//  Copyright (c) 2013年 ou. All rights reserved.
//

#import "MyLibAlertView.h"
@implementation MyLibAlertView

#pragma mark -
#pragma mark Memory management

#pragma mark -
#pragma mark UIView Overrides
- (void)layoutSubviews
{
	for (UIView *subview in self.subviews){
        //ダイアログをカストマイズ
		//NSLog(@"subview class :%@",[subview class]);
		//NSLog(@"subview.tag %i",subview.tag);
		
		if ([subview isMemberOfClass:[UIImageView class]]) {
			//画像
            [subview removeFromSuperview];
            //subview.hidden = YES; //非表示
		} else if ([subview isMemberOfClass:[UILabel class]]) {
            //ラベル
			UILabel *label = (UILabel *)subview;
			label.textColor = [UIColor colorWithRed:40.0f/255.0f green:20.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
			label.shadowColor = [UIColor whiteColor];
			label.shadowOffset = CGSizeMake(0.0f, 1.0f);
		} else if ([subview isMemberOfClass:[UIButton class]]){
             //ボタン
			UIButton *button = (UIButton *)subview;
            CGRect buttonFrame = button.frame;

            int dw = 30, dh=6;
            int x = buttonFrame.origin.x + dw/2;
            int y = buttonFrame.origin.y + dh/2;
            int w = buttonFrame.size.width - dw;
            int h = buttonFrame.size.height - dh;

            buttonFrame = CGRectMake(x, y, w, h);
            button.frame = buttonFrame;
		}
	}
}

- (void)drawRect:(CGRect)rect 
{
	//////////////GET REFERENCE TO CURRENT GRAPHICS CONTEXT
	CGContextRef context = UIGraphicsGetCurrentContext();
	
    //////////////CREATE BASE SHAPE WITH ROUNDED CORNERS FROM BOUNDS
	CGRect activeBounds = self.bounds;
	CGFloat cornerRadius = 10.0f;	
	CGFloat inset = 6.5f;	
	CGFloat originX = activeBounds.origin.x + inset;
	CGFloat originY = activeBounds.origin.y + inset;
	CGFloat width = activeBounds.size.width - (inset*2.0f);
	CGFloat height = activeBounds.size.height - (inset*2.0f);
    
	CGRect bPathFrame = CGRectMake(originX, originY, width, height);
    CGPathRef path = [UIBezierPath bezierPathWithRoundedRect:bPathFrame cornerRadius:cornerRadius].CGPath;
	
	//////////////CREATE BASE SHAPE WITH FILL AND SHADOW
	CGContextAddPath(context, path);
	CGContextSetFillColorWithColor(context, [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0f].CGColor);
	CGContextSetShadowWithColor(context, CGSizeMake(0.0f, 1.0f), 6.0f, [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f].CGColor);
    CGContextDrawPath(context, kCGPathFill);
	
	//////////////CLIP STATE
	CGContextSaveGState(context); //Save Context State Before Clipping To "path"
	CGContextAddPath(context, path);
	CGContextClip(context);
	
	//////////////DRAW GRADIENT
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	size_t count = 3;
	CGFloat locations[3] = {0.0f, 0.15f, 1.0f};
	CGFloat components[12] =  {
		255.0f/255.0f, 0.0f/255.0f, 0.0f/255.0f, 1.0f,
        255.0f/255.0f, 170.0f/255.0f, 170.0f/255.0f, 1.0f,
		159.0f/255.0f, 6.0f/255.0f, 9.0f/255.0f, 1.0f,
   };
	CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, count);
    
	CGPoint startPoint = CGPointMake(activeBounds.size.width * 0.5f, 0.0f);
	CGPoint endPoint = CGPointMake(activeBounds.size.width * 0.5f, activeBounds.size.height);
    
	CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
	CGColorSpaceRelease(colorSpace);
	CGGradientRelease(gradient);
}

@end

