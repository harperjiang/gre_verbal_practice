//
//  Question.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/9/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "Question.h"
#import "ExamSuite.h"
#import "QuestionSet.h"

@implementation Question

@dynamic text;
@dynamic explanation;
@dynamic options;
@dynamic answers;
@dynamic uid;
@dynamic examSuite;
@dynamic questionSet;

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
