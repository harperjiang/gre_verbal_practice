//
//  UIUtils.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/14/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIUtils : NSObject

+ (void)drawText:(CGContextRef) context text:(NSString*) text at:(CGPoint) location with:(CGColorRef) color within:(CGRect) range;
+ (NSInteger) defaultTextSize;
+ (CGSize) textBound:(NSString*) text;
+ (NSInteger) getDefaultTextboxHeight;

+ (UIColor*)navbarColor;
+ (UIColor*)menuColor;
+ (UIColor*)backgroundColor;
@end
