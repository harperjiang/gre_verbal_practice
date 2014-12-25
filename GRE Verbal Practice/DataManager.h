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

- (NSArray*)getVocabs:(NSInteger)count;
- (void)updateVocabProgress:(Vocabulary*)vocab;
- (NSInteger)getVocabCount;
- (NSInteger)getFutureVocabCount;


- (NSArray*)getQuestions:(QuestionType)type count:(NSInteger)count;

- (void)deleteAll:(NSString*)type;

- (BOOL)save;

- (void)deleteAll;
- (void)reset;

@end
