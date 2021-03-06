//
//  RCQuestion.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/9/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "Question.h"
#import "RCText.h"

/*
 * Reading Comprehension Question
 */
@interface RCQuestion : Question

@property(nonatomic, readwrite, strong) RCText* readText;
@property(nonatomic, readwrite) BOOL multiple;
@property(nonatomic, readwrite) BOOL selectSentence;

@end
