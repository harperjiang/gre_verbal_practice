//
//  QuestionSet.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/9/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Question.h"

@interface QuestionSet : NSObject {
    NSInteger current;
}

@property(nonatomic, readwrite, strong) NSArray* questions;
@property(nonatomic, readwrite, strong) NSMutableArray* answers;
@property(nonatomic, readwrite) QuestionType type;

- (Question*)nextQuestion;
- (void)answer: (NSArray*)answer;
@end
