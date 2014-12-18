//
//  TCAnswerView.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/14/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnswerListener.h"
#import "GREButton.h"

@interface TCAnswerView : UIView<ButtonListener> {
    NSMutableArray* _groups;
    NSArray* widthConstraint;
    NSArray* heightConstraint;
}

@property(nonatomic, readwrite, strong) NSArray* options;
@property(nonatomic, readwrite) CGSize preferredSize;
@property(nonatomic, readwrite, weak) id<AnswerListener> answerListener;

- (void)showAnswer:(NSArray*)answer;

@end
