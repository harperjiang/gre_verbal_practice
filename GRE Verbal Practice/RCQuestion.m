//
//  RCQuestion.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/9/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "RCQuestion.h"

@implementation RCQuestion

@dynamic readText,options,answers;

- (QuestionType)type {
    return READING_COMP;
}

- (BOOL)verifyAnswer:(id)answer {
    if(answer == [Question emptyAnswer])
        return NO;
    return [self.answers isEqualToArray:(NSArray*) answer];
}

@end
