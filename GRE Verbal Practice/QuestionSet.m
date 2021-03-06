//
//  QuestionSet.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/9/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "QuestionSet.h"
#import "DataManager.h"
#import "UserPreference.h"

@implementation QuestionSet

@dynamic uid;
@dynamic name, detail, lastVisited;
@dynamic questions;
@dynamic rawType;
@dynamic difficulty;

@synthesize answers;

+ (QuestionSet*) create:(QuestionType)qt difficulty:(NSInteger) difficulty{
    NSInteger questionCount = [UserPreference getInteger: USER_QUES_PER_SET defval:USER_QUES_PER_SET_DEFAULT];
    
    NSArray* questions = [[DataManager defaultManager] getQuestions:qt
                                                          diffculty:difficulty
                                                              count:questionCount];
    QuestionSet* qs = [[QuestionSet alloc] init];
    [qs setType:qt];;
    [qs setQuestions: [[NSOrderedSet alloc]initWithArray:questions]];
    return qs;
}

- (id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context {
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
    if(self) {
        self->current = 0;
        self.answers = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)reset {
    self->current = 0;
}

- (BOOL)isEmpty {
    return self.questions == nil || self.questions.count == 0;
}

- (Question*)question {
    if(self.questions == nil)
        return nil;
    return [self.questions objectAtIndex:current];
}

- (BOOL)prev {
    if([self isEmpty])
        return NO;
    if(self->current <= 0)
        return NO;
    self->current--;
    return YES;
}

- (BOOL)next {
    if([self isEmpty])
        return NO;
    if(self->current >= self.questions.count - 1)
        return NO;
    self->current ++;
    return YES;
}

- (void)answer:(NSArray *)answer index:(NSInteger)index {
    while(self.answers.count <= index) {
        [self.answers addObject:[Question emptyAnswer]];
    }
    [self.answers replaceObjectAtIndex:index withObject: answer];
}

- (void)answer:(NSArray *)answer {
    [self answer:answer index: current];
}

- (NSArray*)answerForIndex:(NSInteger)index {
    if(self.answers.count <= index)
        return [Question emptyAnswer];
    return [self.answers objectAtIndex:index];
}

- (Score*)score {
    return [Scorer scoreWithSet:self.questions answer: self.answers];
}

- (NSInteger)current {
    return current;
}

- (NSInteger)size {
    return self.questions.count;
}

- (QuestionType)type {
    return (QuestionType)[self.rawType intValue];
}

- (void)setType:(QuestionType)type {
    [self setRawType:[NSNumber numberWithInt:type]];
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
