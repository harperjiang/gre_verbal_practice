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
    BOOL _dirty;
}

@property(nonatomic, readwrite, strong) NSArray* options;
@property(nonatomic, readwrite, strong) NSArray* answers;
@property(nonatomic, readwrite) BOOL shouldShowAnswer;

@property(nonatomic, readwrite) CGFloat preferredWidth;
@property(nonatomic, readwrite) CGFloat preferredHeight;

@property(nonatomic, readwrite, weak) id<AnswerListener> answerListener;

- (void)showChoice:(NSArray*)choice;

@end
