//
//  RCAnswerView.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/15/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GREButton.h"
#import "AnswerListener.h"

@interface RCAnswerView : UIView<ButtonListener> {
    BOOL _dirty;
}

@property(nonatomic) BOOL multiple;
@property(nonatomic) NSArray* options;
@property(nonatomic) NSArray* answers;
@property(nonatomic) BOOL shouldShowAnswer;
@property(nonatomic) CGFloat preferredWidth;
@property(nonatomic) CGFloat preferredHeight;
@property(nonatomic, readwrite, weak) id<AnswerListener> answerListener;

- (void)showChoice:(NSArray*)choice;
- (void)setOptions:(NSArray *)options multiple:(BOOL)multiple;

@end
