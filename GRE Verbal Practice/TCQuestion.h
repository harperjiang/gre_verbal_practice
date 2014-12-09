//
//  TCQuestion.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/9/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "Question.h"

/*
 * Text Completion
 */
@interface TCQuestion : Question

@property (nonatomic, readwrite) NSArray* options;
@property (nonatomic, readwrite) NSArray* answers;

@end
