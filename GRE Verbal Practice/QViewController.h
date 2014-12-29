//
//  Header.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/17/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#ifndef GRE_Verbal_Practice_QViewController_h
#define GRE_Verbal_Practice_QViewController_h

#import "Question.h"
#import "AnswerListener.h"

@protocol QViewController <NSObject>

- (void)setQuestionData:(Question*) data;
- (Question*)questionData;
- (void)showAnswer;
- (void)showExplanation;
- (void)showChoice:(NSArray*)choice;
- (void)setAnswerListener:(id<AnswerListener>)listener;

@end

#endif
