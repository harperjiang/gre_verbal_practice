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

// Array of array, contains question options
@property (nonatomic, readwrite) NSArray* options;
// Array of NSString, contains correct answer for each blank
@property (nonatomic, readwrite) NSArray* answers;

@end
