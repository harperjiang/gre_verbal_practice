//
//  GRERadioButton.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/9/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "GRERadioButton.h"

@implementation GRERadioButton

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    
    CGRect range = CGRectMake(1, rect.size.height / 6, rect.size.width-2, rect.size.height * 2 / 3);
    
    CGContextStrokeEllipseInRect(context, range);
    if(self.chosen) {
        CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
        CGContextFillEllipseInRect(context, range);
    } else if(self.rightAnswer) {
        CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
        CGContextFillEllipseInRect(context, range);
    }
    
    CGContextRestoreGState(context);
}


@end
