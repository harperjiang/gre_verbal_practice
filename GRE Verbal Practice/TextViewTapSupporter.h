//
//  TextViewTapSupporter.h
//  GRE Verbal Practice
//
//  Created by Harper on 1/5/15.
//  Copyright (c) 2015 Hao Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define CUAttributeSentenceNum @"cu.attribute.sentence.num"
#define CUAttributeParagraphNum @"cu.attribute.paragraph.num"

@interface TextViewTapSupporter : NSObject<UITextViewDelegate> {
    NSInteger _selectedSentence;
}

@property(nonatomic, weak) UITextView* textView;
@property(nonatomic) UIFont* font;

+ (NSMutableAttributedString*) parse:(NSString*) input;

- (void) onTap: (UITapGestureRecognizer*) tap;
- (void) setText: (NSString*) text;
- (NSInteger) selectedSentence;

- (void)markSentences: (NSArray*)choice highlight:(BOOL)h;
- (void)selectSentences:(NSArray *)choice highlight:(BOOL)h;


@end
