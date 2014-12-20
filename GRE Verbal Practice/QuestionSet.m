//
//  QuestionSet.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/9/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "QuestionSet.h"
#import "Scorer.h"
#import "DataManager.h"
#import "UserPreference.h"

@implementation QuestionSet

+ (QuestionSet*) create:(QuestionType)qt {
    NSInteger questionCount = [UserPreference getInteger: USER_QUES_PER_SET defval:USER_QUES_PER_SET_DEFAULT];
    QuestionSet* qs = [[QuestionSet alloc] init];
    [qs setQuestions:
     [[DataManager defaultManager] getQuestions:qt count:questionCount]];
    return qs;
}

- (id)init {
    self = [super init];
    if(self) {
        self->next = 0;
        self.answers = [[NSMutableArray alloc] init];
    }
    return self;
}

- (Question*)nextQuestion {
    if(self.questions == nil)
        return nil;
    if(self->next == self.questions.count)
        return nil;
    Question* result = (Question*)[self.questions objectAtIndex:next];
    next++;
    return result;
}

- (void)answer:(NSArray *)answer index:(NSInteger)index {
    while(self.answers.count <= index) {
        [self.answers addObject:[Question emptyAnswer]];
    }
    [self.answers replaceObjectAtIndex:index withObject: answer];
}

- (void)answer:(NSArray *)answer {
    [self answer:answer index: next - 1];
}

- (NSString*)score {
    return [Scorer score:self.questions answer: self.answers];
}

@end
