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

- (NSManagedObjectContext*) getContext;

// Vocabularies
- (NSArray*)getVocabGroups;
- (NSInteger)getVocabCount:(VocabGroup*)group;
- (NSArray*)getVocabs:(NSInteger)count ingroup:(VocabGroup*)group;
- (NSInteger)getDoneVocabCount:(VocabGroup*)group;
- (NSInteger)getFutureVocabCount:(VocabGroup*)group;

// Questions and Sets
- (NSArray*)getQuestions:(QuestionType)type count:(NSInteger)count;

- (NSArray*)getQuestionSets:(QuestionType)type;


// Exam Suites
- (NSArray*)getExamSuites;


// General Operations
- (void)deleteAll:(NSString*)type;
- (BOOL)save;
- (void)deleteAll;
- (void)reset;

@end
