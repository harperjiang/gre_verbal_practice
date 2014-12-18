//
//  Question.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/9/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum { SENTENCE_EQUIV = 1, READING_COMP, TEXT_COMPLETION } QuestionType;

@interface Question : NSObject

@property (nonatomic, readwrite) NSString* text;

- (QuestionType)type;

@end
