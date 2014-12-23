//
//  Question.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/9/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef enum { SENTENCE_EQUIV = 1, READING_COMP, TEXT_COMPLETION } QuestionType;

@interface Question : NSManagedObject

@property (nonatomic, readwrite) NSString* text;
@property (nonatomic, readwrite) NSString* explanation;

+ (id)emptyAnswer;

- (QuestionType)type;
- (BOOL)verifyAnswer:(id)answer;

@end
