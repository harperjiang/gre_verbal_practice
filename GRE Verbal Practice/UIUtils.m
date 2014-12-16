//
//  UIUtils.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/14/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "UIUtils.h"
#import <CoreText/CoreText.h>

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

@end
