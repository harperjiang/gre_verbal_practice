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


@interface DataManager : NSObject {
    NSManagedObjectContext* _memoryContext;
}

+ (DataManager*)defaultManager;

- (NSManagedObjectContext*) getContext;
- (NSManagedObjectContext*) getTempContext;

// Vocabularies
- (NSInteger)getVocabCount;
- (NSArray*)getVocabGroups;
- (NSInteger)getVocabCount:(VocabGroup*)group;
- (NSArray*)getVocabs:(NSInteger)count ingroup:(VocabGroup*)group;
- (NSInteger)getDoneVocabCount:(VocabGroup*)group;
- (NSInteger)getFutureVocabCount:(VocabGroup*)group;

- (Vocabulary*)getVocab:(NSInteger)count;

// Questions and Sets
- (NSArray*)getQuestions:(QuestionType)type diffculty:(NSInteger) diffculty count:(NSInteger)count;
- (NSArray*)getQuestionSets:(QuestionType)type;


// Exam Suites
- (NSArray*)getExamSuites;


// General Operations
- (void)deleteAll:(NSString*)type;
- (BOOL)save;
- (void)deleteAll;
- (void)reset;

@end
