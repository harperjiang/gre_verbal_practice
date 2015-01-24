//
//  ExamSuite.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/16/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Question.h"
#import "Scorer.h"

@interface ExamSuite : NSManagedObject

@property(nonatomic) NSString* name;
@property(nonatomic) NSString* statistics;
@property(nonatomic) NSDate* lastVisited;
@property(nonatomic) NSOrderedSet* questions;
@property(nonatomic) NSMutableArray* answers;
@property(nonatomic) NSInteger current;
@property(nonatomic) NSNumber* timeLimit;
@property(nonatomic) long timeRemain;

+ (ExamSuite*)create;

- (NSInteger)size;
- (BOOL)next;
- (BOOL)prev;
- (Question*)question;
- (NSArray*)currentAnswer;
- (void)answer: (NSArray*)answer for:(NSInteger)i;
- (Score*)score;
- (void)reset;

@end
