//
//  ExamSuite.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/16/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "ExamSuite.h"
#import "Scorer.h"

@implementation ExamSuite

- (id)init {
    self = [super init];
    if(self) {
        self->_current = 0;
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
        self->_current--;
        return YES;
    }
    return NO;
}

- (BOOL)next {
    if(self.questions != nil && self.current < self.questions.count - 1) {
        self->_current++;
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

- (NSString*)score {
    return [Scorer score:self.questions answer: self.answers];
}

@end
