//
//  VocabQuiz.m
//  GRE Verbal Master
//
//  Created by Harper on 1/30/15.
//  Copyright (c) 2015 Hao Jiang. All rights reserved.
//

#import "VocabQuiz.h"
#import "VocabQuizSet.h"

@implementation VocabQuiz

- (instancetype)init {
    self = [super init];
    if (self) {
        self.userAnswer = -1;
    }
    return self;
}

- (NSDictionary *)answerInfo {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:@"" forKey:@"user"];
    [dict setObject:[self.options objectAtIndex:self.answer - 1] forKey:@"answer"];
    
    if (self.userAnswer != -1) {
        [dict setObject:[self.options objectAtIndex:self.userAnswer - 1] forKey:@"user"];
    }
    
    return dict;
}

@end
