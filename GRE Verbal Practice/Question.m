//
//  Question.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/9/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "Question.h"

@implementation Question

@dynamic text;

static NSArray* empty;

+ (id)emptyAnswer {
    if(empty == nil) {
        empty = [[NSArray alloc] init];
    }
    return empty;
}

- (QuestionType)type {
    return 0;
}

- (BOOL)verifyAnswer:(id)answer {
    return NO;
}

@end
