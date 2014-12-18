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
    NSArray* widthConstraint;
    NSArray* heightConstraint;
}

@property(nonatomic,readwrite,retain) NSArray* options;
@property(nonatomic, readwrite, weak) id<AnswerListener> answerListener;

- (void)showAnswers:(NSArray*)answers;

@end
