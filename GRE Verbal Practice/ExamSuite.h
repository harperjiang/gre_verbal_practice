//
//  ExamSuite.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/16/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Question.h"

@interface ExamSuite : NSObject

@property(nonatomic, readwrite, strong) NSArray* questions;
@property(nonatomic, readwrite, strong) NSMutableArray* answers;
@property(nonatomic, readonly) NSInteger current;
@property(nonatomic, readwrite) NSInteger timeLimit;

+ (ExamSuite*)create;

- (NSInteger)size;
- (BOOL)next;
- (BOOL)prev;
- (Question*)question;
- (void)answer: (NSArray*)answer for:(NSInteger)i;
- (NSString*)score;

@end
