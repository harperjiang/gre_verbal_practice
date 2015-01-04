//
//  RCQuestion.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/9/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "RCQuestion.h"

@implementation RCQuestion

@dynamic readText, options, answers, multiple;

- (QuestionType)type {
    return READING_COMP;
}

- (BOOL)verifyAnswer:(NSArray*)answer {
    if(answer == [Question emptyAnswer])
        return NO;
    return [self.answers isEqualToArray:(NSArray*) answer] || [self.answers isEqualToArray:[self translate: answer]];
}

- (NSArray*)translate:(NSArray*)inputs {
    NSMutableArray* result = [[NSMutableArray alloc] initWithCapacity:inputs.count];
    for(NSNumber* input in inputs) {
        NSInteger val = [input integerValue];
        if(val == -1) {
            [result addObject: input];
        } else {
            [result addObject:[NSNumber numberWithInteger: val - 1]];
        }
    }
    return result;
}

@end
