//
//  AnswerListener.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/17/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#ifndef GRE_Verbal_Practice_AnswerListener_h
#define GRE_Verbal_Practice_AnswerListener_h

@protocol AnswerListener<NSObject>

- (void)answerChanged:(NSArray*)answer;

@end

#endif
