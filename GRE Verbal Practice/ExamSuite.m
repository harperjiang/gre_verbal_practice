//
//  ExamSuite.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/16/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "ExamSuite.h"
#import "DataManager.h"
#import "UserPreference.h"

@implementation ExamSuite

@dynamic name;
@dynamic lastVisited;
@dynamic statistics;
@dynamic questions;
@dynamic timeLimit;
@synthesize answers;
@synthesize current;
@synthesize timeRemain;

+ (ExamSuite*)create {
    ExamSuite* esuite = [[ExamSuite alloc] init];
    NSMutableOrderedSet* questions = [[NSMutableOrderedSet alloc] init];
    [questions addObjectsFromArray:[[DataManager defaultManager] getQuestions: TEXT_COMPLETION count: 5]];
    [questions addObjectsFromArray:[[DataManager defaultManager] getQuestions: SENTENCE_EQUIV count: 4]];
    [questions addObjectsFromArray:[[DataManager defaultManager] getQuestions: READING_COMP count: 4]];
    [esuite setQuestions:questions];
    NSInteger val = [UserPreference getInteger:USER_EXAM_TIMELIMIT defval:USER_EXAM_TIMELIMIT_DEFAULT];
    [esuite setTimeLimit: [NSNumber numberWithInteger:val]];
    return esuite;
}



- (id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context {
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
    if(self) {
        self.current = 0;
        self.answers = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSInteger)size {
    if(self.questions == nil)
        return 0;
    return self.questions.count;
}

- (BOOL)prev {
    if(self.current > 0) {
        self.current--;
        return YES;
    }
    return NO;
}

- (BOOL)next {
    if(self.questions != nil && self.current < ((NSInteger)self.questions.count) - 1) {
        self.current++;
        return YES;
    }
    return NO;
}

- (Question*)question {
    if(self.questions == nil || self.questions.count == 0)
        return nil;
    return (Question*)[self.questions objectAtIndex:self.current];
}

- (void)answer:(NSArray *)answer for:(NSInteger)i {
    if(self.questions == nil) {
        @throw [[NSException alloc] initWithName:@"NPE" reason:@"Question list is empty" userInfo:nil];
    }
    if(i < 0 && i >= self.questions.count) {
        @throw [[NSException alloc] initWithName:@"OOB" reason:@"Out of Bound" userInfo:nil];
    }
    while(self.answers.count <= i) {
        [self.answers addObject:[Question emptyAnswer]];
    }
    [self.answers replaceObjectAtIndex:i withObject: answer];
}

- (Score*)score {
    return [Scorer scoreWithSet:self.questions answer: self.answers];
}

- (NSArray*)currentAnswer {
    if(self.answers.count <= self.current)
        return [Question emptyAnswer];
    return [self.answers objectAtIndex:self.current];
}

- (void)reset {
    self.current = 0;
    self.answers = [[NSMutableArray alloc] init];
}

@end
