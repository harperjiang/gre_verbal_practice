//
//  DataManager.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/16/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VocabPlan.h"
#import "Question.h"


@interface DataManager : NSObject

+ (DataManager*)defaultManager;

- (NSArray*)getVocabs:(NSInteger)count;
- (void)updateVocabProgress:(Vocabulary*)vocab;

- (NSArray*)getQuestions:(QuestionType)type count:(NSInteger)count;


- (void)reset;

@end
