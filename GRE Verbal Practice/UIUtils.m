//
//  UIUtils.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/14/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "UIUtils.h"
#import <CoreText/CoreText.h>

#define COLOR(x) ((double)x)/255

@implementation UIUtils

+(NSInteger) defaultTextSize {
    return 16;
}

+(NSInteger) getDefaultTextboxHeight {
    return [UIUtils defaultTextSize] + 12;
}

+(void) drawText:(CGContextRef)context text:(NSString *)text at:(CGPoint)location  with:(CGColorRef) color within:(CGRect) range {
    CFStringRef font_name = CFStringCreateWithCString(NULL, "Helvetica", kCFStringEncodingMacRoman);
    CTFontRef font = CTFontCreateWithName(font_name, [UIUtils defaultTextSize], NULL);
    CFStringRef keys[] = { kCTFontAttributeName, kCTForegroundColorAttributeName };
    CFTypeRef values[] = { font, color };
    CFDictionaryRef font_attributes = CFDictionaryCreate(kCFAllocatorDefault, (const void **)&keys, (const void **)&values, sizeof(keys) / sizeof(keys[0]), &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    CFRelease(font_name);
    
    CFRelease(font);
    
    const char *ctext = [text UTF8String];
    
    CFStringRef string = CFStringCreateWithCString(NULL, ctext, kCFStringEncodingMacRoman);
    CFAttributedStringRef attr_string = CFAttributedStringCreate(NULL, string, font_attributes);
    CTLineRef line = CTLineCreateWithAttributedString(attr_string);
    CGContextSetTextPosition(context, location.x, location.y);
    
    // Core Text uses a reference coordinate system with the origin on the bottom-left
    // flip the coordinate system before drawing or the text will appear upside down
    CGContextTranslateCTM(context, 0, range.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CTLineDraw(line, context);
    CFRelease(line);
    CFRelease(string);
    CFRelease(attr_string);
}

+(CGSize) textBound:(NSString *)text {
    CFStringRef font_name = CFStringCreateWithCString(NULL, "Helvetica", kCFStringEncodingMacRoman);
    CTFontRef font = CTFontCreateWithName(font_name, [UIUtils defaultTextSize], NULL);
    CFStringRef keys[] = { kCTFontAttributeName };
    CFTypeRef values[] = { font };
    CFDictionaryRef font_attributes = CFDictionaryCreate(kCFAllocatorDefault, (const void **)&keys, (const void **)&values, sizeof(keys) / sizeof(keys[0]), &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    CFRelease(font_name);
    
    CFRelease(font);
    
    const char *ctext = [text UTF8String];
    
    CFStringRef string = CFStringCreateWithCString(NULL, ctext, kCFStringEncodingMacRoman);
    CFAttributedStringRef attr_string = CFAttributedStringCreate(NULL, string, font_attributes);
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString(attr_string); /*Create your framesetter based in you NSAttrinbutedString*/
    CGFloat widthConstraint = 1000; // Your width constraint, using 500 as an example
    CGSize suggestedSize = CTFramesetterSuggestFrameSizeWithConstraints(
        frameSetter, /* Framesetter */
        CFRangeMake(0, text.length), /* String range (entire string) */
        NULL, /* Frame attributes */
        CGSizeMake(widthConstraint, 150), /* Constraints (CGFLOAT_MAX indicates unconstrained) */
        NULL /* Gives the range of string that fits into the constraints, doesn't matter in your situation */);
    
    CFRelease(string);
    CFRelease(attr_string);
    CFRelease(frameSetter);
    return suggestedSize;
}

+ (UIColor*)menuColor {
    return [UIColor colorWithRed:0.3 green:0.49 blue:0.8 alpha:1];
}

+ (UIColor*)navbarColor {
    return [UIColor colorWithRed:0.23 green:0.35 blue:0.6 alpha:0.8];
}

+ (UIColor*)backgroundColor {
//    return [UIColor colorWithRed:0.86 green:0.88 blue:0.92 alpha:1];
    return [UIColor colorWithRed:1 green:0.98 blue:0.96 alpha:1];
}

+ (UIColor *)chromeYellow {
    return [UIColor colorWithRed:COLOR(252) green:COLOR(214) blue:COLOR(48) alpha:1];
}

+ (UIColor *)chromeGreen {
    return [UIColor colorWithRed:COLOR(62) green:COLOR(233) blue:COLOR(117) alpha:1];
}

+ (UIColor *)chromeRed {
    return [UIColor colorWithRed:COLOR(226) green:COLOR(119) blue:COLOR(50) alpha:1];
}

+ (UIColor*)lightGreen {
    return [UIColor colorWithRed:COLOR(220) green:COLOR(250) blue:COLOR(220) alpha:1];
}

+ (UIColor*)darkGreen {
    return [UIColor colorWithRed:COLOR(32) green:COLOR(126) blue:COLOR(119) alpha:1];

}

+ (UIColor*)darkBlue {
    return [UIColor colorWithRed:COLOR(23) green:COLOR(145) blue:COLOR(212) alpha:1];
    
}

+ (void)popAndPush:(UINavigationController *)nav push:(UIViewController *)push animate:(BOOL)animate{
    NSMutableArray *controllers=[[NSMutableArray alloc] initWithArray:nav.viewControllers] ;
    UIViewController* last = [controllers lastObject];
    [last willMoveToParentViewController:nil];
    [controllers removeLastObject];
    [nav setViewControllers:controllers];
    [last removeFromParentViewController];
    [last didMoveToParentViewController:nil];
    [nav pushViewController: push animated:animate];
}

@end
