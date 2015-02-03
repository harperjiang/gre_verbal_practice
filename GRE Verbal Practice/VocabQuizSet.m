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
    
    
    for (int i = 0 ; i < 10 ; i++) {
        VocabQuiz* quiz = [[VocabQuiz alloc] init];
        Vocabulary* vocab = [[DataManager defaultManager] getVocab: arc4random()%600];
        quiz.question = vocab.word;
        quiz.explanation = vocab.explanation;
        
        NSMutableArray* options = [[NSMutableArray alloc] init];
        for(int j = 0 ; j < 4 ; j++) {
            Vocabulary* vocab = [[DataManager defaultManager] getVocab: arc4random()%600];
            [options addObject:vocab.word];
        }
        quiz.options = options;
        quiz.answer = 1;
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
        self->_answers = [[NSMutableArray alloc] init];
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

- (NSInteger)answer:(NSInteger)answer {
    while (self.answers.count < _index) {
        [self.answers addObject:[NSNumber numberWithInt:-1]];
    }
    [self.answers setObject:[NSNumber numberWithInteger:answer] atIndexedSubscript:_index];
    NSInteger score = 0;
    if(answer == self.current.answer) {
        // TODO Scoring logic
        score = 100 + arc4random()%100;
        self->_correct += 1;
    }
    self.score += score;
    return score;
}

- (NSInteger)answerFor:(NSInteger)index {
    if (index >= self.answers.count)
        return -1;
    return [[self.answers objectAtIndex:index] integerValue];
}

@end
