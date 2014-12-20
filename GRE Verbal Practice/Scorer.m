//
//  Scorer.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/19/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "Scorer.h"
#import "Question.h"

@implementation Scorer


+ (NSString*)score:(NSArray*)questions answer:(NSArray*)answers {
    NSInteger count = 0;
    for(int i = 0 ; i < questions.count ; i++) {
        Question* q = [questions objectAtIndex:i];
        if(answers.count > i && [q verifyAnswer: [answers objectAtIndex:i]]) {
            count++;
        }
    }
    return [NSString stringWithFormat:@"%ld/%ld", count, questions.count];
}

@end
