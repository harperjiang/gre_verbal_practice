//
//  QuestionSet.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/9/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "QuestionSet.h"

@implementation QuestionSet

- (id)init {
    self = [super init];
    if(self) {
        self->current = 0;
        self.answers = [[NSMutableArray alloc] init];
    }
    return self;
}

- (Question*)nextQuestion {
    if(self.questions == nil)
        return nil;
    if(self->current == self.questions.count)
        return nil;
    Question* result = (Question*)[self.questions objectAtIndex:current];
    current ++;
    return result;
}

- (void)answer:(NSArray *)answer{
    while(self.answers.count <= current) {
        [self.answers addObject:nil];
    }
    [self.answers replaceObjectAtIndex:current withObject: answer];
}

@end
