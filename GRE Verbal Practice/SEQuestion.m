//
//  SEQuestion.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/9/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "SEQuestion.h"

@implementation SEQuestion

@dynamic options, answers;

- (QuestionType)type {
    return SENTENCE_EQUIV;
}

- (BOOL)verifyAnswer:(id)answer {
    if(answer == [Question emptyAnswer])
        return NO;
    return [self.answers isEqualToArray:(NSArray*) answer];
}

@end
