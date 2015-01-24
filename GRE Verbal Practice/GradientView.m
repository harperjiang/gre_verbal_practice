//
//  GradientView.m
//  GRE Verbal Master
//
//  Created by Harper on 1/21/15.
//  Copyright (c) 2015 Hao Jiang. All rights reserved.
//

#import "GradientView.h"

@implementation GradientItem

@end

@implementation GradientView

-(void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGFloat* colordata = (CGFloat*)malloc(self.colors.count*4*sizeof(CGFloat));
    CGFloat* location = (CGFloat*)malloc(self.colors.count*sizeof(CGFloat));
    for(int i = 0 ; i < self.colors.count ; i++ ) {
        GradientItem* item = [self.colors objectAtIndex:i];
        const CGFloat* cmp = CGColorGetComponents(item.color.CGColor);
        for(int j = 0 ; j < 4 ; j++) {
            colordata[i*4+j] = cmp[j];
        }
        location[i] = item.location;
    }
    
    CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(baseSpace, colordata, location, self.colors.count);

    
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(baseSpace);
    free(colordata);
    free(location);
    gradient = NULL;
    
    CGContextRestoreGState(context);
}

@end
