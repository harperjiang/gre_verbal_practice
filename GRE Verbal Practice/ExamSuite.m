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

@dynamic uid;
@dynamic name;
@dynamic lastVisited;
@dynamic statistics;
@dynamic questions;
@dynamic timeLimit;
@dynamic difficulty;
@synthesize answers;
@synthesize current;
@synthesize temporary;
@synthesize timeRemain;

+ (ExamSuite*)create:(NSInteger)diffculty {
    NSManagedObjectContext* context = [[DataManager defaultManager] getContext];
    NSEntityDescription* esd = [NSEntityDescription entityForName:@"ExamSuite"
                                           inManagedObjectContext:context];
    ExamSuite* esuite = [[ExamSuite alloc] initWithEntity:esd insertIntoManagedObjectContext: context];
    esuite.temporary = YES;
    esuite.difficulty = [NSNumber numberWithInteger: diffculty];
    NSMutableOrderedSet* questions = [[NSMutableOrderedSet alloc] init];
    [questions addObjectsFromArray:[[DataManager defaultManager] getQuestions: TEXT_COMPLETION
                                                                    diffculty: diffculty
                                                                        count: 5]];
    [questions addObjectsFromArray:[[DataManager defaultManager] getQuestions: SENTENCE_EQUIV
                                                                    diffculty: diffculty
                                                                        count: 4]];
    [questions addObjectsFromArray:[[DataManager defaultManager] getQuestions: READING_COMP
                                                                    diffculty: diffculty
                                                                        count: 4]];
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

- (NSString *)difficultyString {
    switch (self.difficulty.intValue) {
        case 0:
            return @"Hard";
        case 1:
            return @"Normal";
        case 2:
            return @"Easy";
        default:
            return @"";
    }
}
@end
