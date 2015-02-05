//
//  VocabQuizSet.m
//  GRE Verbal Master
//
//  Created by Harper on 1/30/15.
//  Copyright (c) 2015 Hao Jiang. All rights reserved.
//

#import "VocabQuizSet.h"
#import "DataManager.h"
@implementation VocabQuizSet

+ (VocabQuizSet *)create {
    VocabQuizSet* set = [[VocabQuizSet alloc] init];
    
    // TODO Random Generate question and answer
    NSMutableArray* array = [[NSMutableArray alloc] init];
    NSMutableSet* wordSet = [[NSMutableSet alloc] init];
    
    NSInteger totalWord = [[DataManager defaultManager] getVocabCount];
    
    for (int i = 0 ; i < 10 ; i++) {
        VocabQuiz* quiz = [[VocabQuiz alloc] init];
        NSString* synonym = nil;
        while (true) {
            Vocabulary* vocab = [[DataManager defaultManager] getVocab: arc4random()% totalWord];
            if(nil != vocab.synonyms && ![@"" isEqualToString:vocab.synonyms]) {
                quiz.question = vocab.word;
                quiz.explanation = vocab.explanation;
                NSArray* synonyms = [vocab.synonyms componentsSeparatedByString:@","];
                int counter = 0;
                while (counter < synonyms.count) {
                    synonym = [synonyms objectAtIndex:counter];
                    if(![vocab.word isEqualToString:synonym]) {
                        break;
                    }
                    counter++;
                }
                if (![vocab.word isEqualToString:synonym]) {
                    break;
                }
            }
        }
        [wordSet addObject: quiz.question];
        [wordSet addObject: synonym];
        
        NSMutableArray* options = [[NSMutableArray alloc] init];
        while (options.count < 3) {
            Vocabulary* vocab = [[DataManager defaultManager] getVocab: arc4random()%totalWord];
            if(![wordSet containsObject:vocab.word]) {
                [options addObject:vocab.word];
            }
        }
        int answer = arc4random() % 4;
        
        if (answer == 3) {
            [options addObject:synonym];
        } else {
            [options insertObject:synonym atIndex:answer];
        }
        quiz.answer = answer + 1;
        quiz.options = options;
        quiz.header = set;
        [array addObject:quiz];
    }
    set.questions = array;
    
    return set;
}

- (id)init {
    self = [super init];
    if (self) {
        self.score = 0;
        self->_index = 0;
        self->_correct = 0;
    }
    return self;
}

- (NSInteger)size {
    return self.questions.count;
}

- (VocabQuiz *)current {
    return [self.questions objectAtIndex:_index];
}

- (NSInteger)index {
    return _index;
}

- (BOOL)next {
    if (_index < self.questions.count - 1) {
        _index ++;
        return YES;
    }
    return NO;
}

- (NSInteger)correct {
    return _correct;
}

- (NSInteger)answer:(NSInteger)answer time:(NSInteger)time{
    self.current.userAnswer = answer;
    NSInteger score = 0;
    if(answer == self.current.answer) {
        // TODO Scoring logic
        score = 50 + time * 10 + arc4random()%50;
        if(score > 200)
            score = 200;
        self->_correct += 1;
    }
    self.score += score;
    return score;
}

- (NSInteger)answerFor:(NSInteger)index {
    return [(VocabQuiz*)[self.questions objectAtIndex:index] userAnswer];
}

@end
