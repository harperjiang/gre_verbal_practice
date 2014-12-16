//
//  GRETextButton.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/14/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "GRETextButton.h"
#import "UIUtils.h"

@implementation GRETextButton


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);

    CGColorRef background;
    CGColorRef foreground;
    if(self.chosen) {
        background = [UIColor blackColor].CGColor;
        foreground = [UIColor whiteColor].CGColor;
    } else {
        background = [UIColor whiteColor].CGColor;
        foreground = [UIColor blackColor].CGColor;
    }
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextSetLineWidth(context, 2.0);
    CGContextStrokeRect(context, rect);
    
    CGContextSetFillColorWithColor(context, background);
    CGContextFillRect(context, CGRectMake(1, 1, rect.size.width-2, rect.size.height -2));
    
    NSInteger fontSize = [UIUtils defaultTextSize];
    NSInteger ypos = rect.size.height / 2 - fontSize / 2;
    
    [UIUtils drawText:context text:[self text] at:CGPointMake(10, ypos) with:foreground within:rect];
    
    
    CGContextRestoreGState(context);
}

- (CGSize) getPreferredSize {
    CGSize bound = [UIUtils textBound:self.text];
    return CGSizeMake(bound.width + 20, [UIUtils getDefaultTextboxHeight]);
}

@end
