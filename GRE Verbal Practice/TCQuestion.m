//
//  TCQuestion.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/9/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "TCQuestion.h"

@implementation TCQuestion

@dynamic options, answers;

- (QuestionType)type {
    return TEXT_COMPLETION;
}

- (BOOL)verifyAnswer:(id)answer {
    if(answer == [Question emptyAnswer])
        return NO;
    return [self.answers isEqualToArray:(NSArray*) answer];
}

@end
