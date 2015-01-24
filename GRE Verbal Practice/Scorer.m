//
//  Scorer.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/19/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "Scorer.h"
#import "Question.h"

@implementation Score

- (NSString *)scoreText {
    return [NSString stringWithFormat:@"%zd/%zd", self.correct, self.total];
}

- (NSNumber *)scoreValue {
    return [NSNumber numberWithDouble:((double)self.correct)/ self.total];
}

@end

@implementation Scorer


+ (Score*)score:(NSArray*)questions answer:(NSArray*)answers {
    NSInteger count = 0;
    for(int i = 0 ; i < questions.count ; i++) {
        Question* q = [questions objectAtIndex:i];
        if(answers.count > i && [q verifyAnswer: [answers objectAtIndex:i]]) {
            count++;
        }
    }
    Score* score = [[Score alloc] init];
    score.total = questions.count;
    score.correct = count;
    return score;
}

+ (Score*)scoreWithSet:(NSOrderedSet*)questions answer:(NSArray*)answers {
    NSInteger count = 0;
    for(int i = 0 ; i < questions.count ; i++) {
        Question* q = [questions objectAtIndex:i];
        if(answers.count > i && [q verifyAnswer: [answers objectAtIndex:i]]) {
            count++;
        }
    }
    Score* score = [[Score alloc] init];
    score.total = questions.count;
    score.correct = count;
    return score;
}

@end
