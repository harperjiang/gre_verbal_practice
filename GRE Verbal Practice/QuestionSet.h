//
//  QuestionSet.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/9/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Question.h"
#import "Scorer.h"

@interface QuestionSet : NSManagedObject {
    NSInteger current;
}

@property(nonatomic, readwrite) NSString* uid;
@property(nonatomic, readwrite) NSString* name;
@property(nonatomic, readwrite) NSString* detail;
@property(nonatomic, readwrite) NSDate* lastVisited;
@property(nonatomic, readwrite, strong) NSOrderedSet* questions;
@property(nonatomic, readwrite, strong) NSMutableArray* answers;
@property(nonatomic, readwrite) QuestionType type;
@property(nonatomic, readwrite) NSNumber* rawType;
@property(nonatomic, readwrite) NSNumber* difficulty;

+ (QuestionSet*)create:(QuestionType)qt difficulty:(NSInteger) difficulty;

- (BOOL)isEmpty;
- (NSInteger)current;
- (NSInteger)size;
- (void)reset;
- (BOOL)next;
- (BOOL)prev;
- (Question*)question;
- (void)answer: (NSArray*)answer;
- (void)answer:(NSArray *)answer index:(NSInteger)index;
- (NSArray*) answerForIndex:(NSInteger)index;
- (Score*)score;
- (NSString*)difficultyString;
@end
