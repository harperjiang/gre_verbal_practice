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

@property(nonatomic, readwrite, retain) RCText* readText;
@property(nonatomic, readwrite, retain) NSArray* options;

@end
