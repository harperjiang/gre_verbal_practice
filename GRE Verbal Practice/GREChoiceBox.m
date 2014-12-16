//
//  GREChoiceBox.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/9/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "GREChoiceBox.h"

@implementation GREChoiceBox

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextStrokeRect(context, rect);
    if(self.chosen) {
        CGContextMoveToPoint(context, 0, 0);
        CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
        CGContextMoveToPoint(context, 0, rect.size.height);
        CGContextAddLineToPoint(context, rect.size.width, 0);
        CGContextStrokePath(context);
    }
}


@end
