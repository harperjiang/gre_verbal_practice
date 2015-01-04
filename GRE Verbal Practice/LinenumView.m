//
//  LinenumView.m
//  GRE Verbal Practice
//
//  Created by Harper on 1/3/15.
//  Copyright (c) 2015 Hao Jiang. All rights reserved.
//

#import <CoreText/CoreText.h>
#import "LinenumView.h"
#import "UIUtils.h"

@implementation LinenumView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Draw Line numbers
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    
    CGFloat y = rect.size.height - self.margin;
    int i = 1;
    while(true) {
        NSString* number = [NSString stringWithFormat:@"%d",i];
        CGSize size = [number sizeWithAttributes:@{NSFontAttributeName: self.font}];
        CGContextSaveGState(context);
        
        [UIUtils drawText:context
                     text:number
                       at: CGPointMake(rect.size.width - self.border - size.width, y)
                     with:[UIColor blackColor].CGColor
                   within:rect];
        
        CGContextRestoreGState(context);
        y -= size.height + self.lineSpacing;
        i++;
        if(y <= 0)
            break;
    }
    
}

@end
