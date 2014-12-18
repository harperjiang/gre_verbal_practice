//
//  ExamSuite.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/16/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "ExamSuite.h"

@implementation ExamSuite

- (id)init {
    self = [super init];
    if(self) {
        self.current = 0;
        self.answers = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSInteger)size {
    return self.questions.count;
}

- (Question*)prevQuestion {
    if(self.current != 0) {
        self.current--;
        return [self.questions objectAtIndex: self.current];
    }
    return nil;
}

- (Question*)nextQuestion {
    if(self.current < self.questions.count) {
        Question* res = (Question*)[self.questions objectAtIndex: self.current];
        self.current++;
        return res;
    }
    return nil;
}

- (void)answer:(NSArray *)answer for:(NSInteger)i {
    while(self.answers.count <= self.current) {
        [self.answers addObject:nil];
    }
    [self.answers replaceObjectAtIndex:self.current withObject: answer];
}

@end
