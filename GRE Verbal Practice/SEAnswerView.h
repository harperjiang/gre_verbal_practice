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
    NSArray* widthConstraint;
    NSArray* heightConstraint;
    NSMutableArray* buttons;
}

@property(nonatomic, readwrite, retain) NSArray* options;
@property(nonatomic, readwrite, weak) id<AnswerListener> answerListener;

- (void)showAnswer: (NSArray*)answers;

@end
