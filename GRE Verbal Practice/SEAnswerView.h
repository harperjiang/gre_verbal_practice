//
//  SEAnswerView.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/15/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnswerListener.h"
#import "GREButton.h"

@interface SEAnswerView : UIView<ButtonListener> {
    NSMutableArray* buttons;
    BOOL dirty;
}

@property(nonatomic, readwrite, weak) NSArray* options;
@property(nonatomic, readwrite, weak) NSArray* answers;
@property(nonatomic, readwrite, weak) id<AnswerListener> answerListener;
@property(nonatomic, readwrite) CGFloat preferredWidth;
@property(nonatomic, readwrite) CGFloat preferredHeight;

@property(nonatomic) BOOL shouldShowAnswer;

- (void)showChoice:(NSArray*)choice;

@end
