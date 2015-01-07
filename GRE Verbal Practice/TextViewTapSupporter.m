//
//  TextViewTapSupporter.m
//  GRE Verbal Practice
//
//  Created by Harper on 1/5/15.
//  Copyright (c) 2015 Hao Jiang. All rights reserved.
//

#import "TextViewTapSupporter.h"

@implementation TextViewTapSupporter

- (void)onTap:(UITapGestureRecognizer *)tap {
    CGPoint pos = [tap locationInView:self.textView];
    
    //get location in text from textposition at point
    UITextPosition *tapPos = [self.textView closestPositionToPoint:pos];
    
    //fetch the word at this position (or nil, if not available)
    UITextRange * wr =
    [self.textView.tokenizer rangeEnclosingPosition:tapPos
                                    withGranularity:UITextGranularitySentence
                                        inDirection:UITextLayoutDirectionRight];
    
    NSAttributedString* origin = self.textView.attributedText;
    
    NSInteger from = [self.textView offsetFromPosition:self.textView.beginningOfDocument
                                            toPosition:wr.start];
    NSInteger to =[self.textView offsetFromPosition:self.textView.beginningOfDocument
                                         toPosition:wr.end];
    
    NSRange range = NSMakeRange(from, to - from);
    
    NSNumber* selected = [origin attribute:CUAttributeSentenceNum atIndex:from effectiveRange:&range];
    
    CGPoint offset = self.textView.contentOffset;
    if(selected.integerValue == _selectedSentence) {
        [self selectSentences:@[selected] highlight:NO];
        _selectedSentence = 0;
    } else {
        [self selectSentences:@[[NSNumber numberWithInteger:_selectedSentence]]
                    highlight:NO];
        [self selectSentences:@[selected] highlight:YES];
        _selectedSentence = selected.integerValue;
    }
    [[NSOperationQueue mainQueue] addOperationWithBlock: ^{
        [self.textView setContentOffset: offset];
    }];
}

- (void)setText:(NSString *)text {
    NSMutableAttributedString* string = [TextViewTapSupporter parse: text];
    [string addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, text.length)];
    [self.textView setAttributedText: string];
}

- (NSInteger) selectedSentence {
    return _selectedSentence;
}

- (void)markSentences: (NSArray*)choice highlight:(BOOL)h {
    NSAttributedString* origin = self.textView.attributedText;
    NSMutableAttributedString* replace = [[NSMutableAttributedString alloc] initWithAttributedString:origin];
    NSSet *cc = [[NSSet alloc] initWithArray:choice];
    NSDictionary* attrs = nil;
    if(h) {
        attrs = @{NSForegroundColorAttributeName: [UIColor blackColor],
                  NSBackgroundColorAttributeName: [UIColor redColor]};
    } else {
        attrs = @{NSForegroundColorAttributeName: [UIColor blackColor],
                  NSBackgroundColorAttributeName: [UIColor clearColor]};
    }
    [origin enumerateAttribute:CUAttributeSentenceNum
                       inRange:NSMakeRange(0, replace.length)
                       options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired
                    usingBlock:^(id value, NSRange range, BOOL *stop) {
                         NSNumber* num = (NSNumber*)value;
                         if([cc containsObject:num]) {
                             [replace addAttributes: attrs range:range];
                         }
                     }];
    CGPoint offset = self.textView.contentOffset;
    self.textView.attributedText = replace;
    [[NSOperationQueue mainQueue] addOperationWithBlock: ^{
        [self.textView setContentOffset: offset];
    }];
}

- (void)selectSentences:(NSArray *)choice highlight:(BOOL)h {
    NSAttributedString* origin = self.textView.attributedText;
    NSMutableAttributedString* replace = [[NSMutableAttributedString alloc] initWithAttributedString:origin];
    NSSet *cc = [[NSSet alloc] initWithArray:choice];
    NSDictionary* attrs = nil;
    if(h) {
        attrs = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                  NSBackgroundColorAttributeName: [UIColor blackColor]};
    } else {
        attrs = @{NSForegroundColorAttributeName: [UIColor blackColor],
                  NSBackgroundColorAttributeName: [UIColor clearColor]};
    }
    [origin enumerateAttribute:CUAttributeSentenceNum
                       inRange:NSMakeRange(0, origin.length)
                       options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired
                    usingBlock:^(id value, NSRange range, BOOL *stop) {
                         NSNumber* num = (NSNumber*)value;
                         if([cc containsObject:num]) {
                             [replace addAttributes: attrs range:range];
                         }
                     }];
    CGPoint offset = self.textView.contentOffset;
    self.textView.attributedText = replace;
    [[NSOperationQueue mainQueue] addOperationWithBlock: ^{
        [self.textView setContentOffset: offset];
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%f,%f",scrollView.contentOffset.x, scrollView.contentOffset.y);
}

+ (NSMutableAttributedString *)parse:(NSString *)input {
    
    NSMutableAttributedString* result = [[NSMutableAttributedString alloc] initWithString:input];
    
    __block NSInteger paragraphCount = 1;
    __block NSInteger sentenceCount = 1;
    
    [input enumerateSubstringsInRange: NSMakeRange(0, input.length) options:NSStringEnumerationBySentences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        [result addAttribute: CUAttributeSentenceNum value: [NSNumber numberWithInteger:sentenceCount] range:enclosingRange];
        
        NSString *part = [substring stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceCharacterSet]];
        if([part hasSuffix:@"Dr."] || [part hasSuffix:@"Mr."]) {
            return;
        } else {
            sentenceCount++;
        }
    }];
    [input enumerateSubstringsInRange: NSMakeRange(0, input.length) options:NSStringEnumerationByParagraphs usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        [result addAttribute: CUAttributeParagraphNum value: [NSNumber numberWithInteger:paragraphCount] range:enclosingRange];
        paragraphCount++;
    }];
    return result;
}

@end
