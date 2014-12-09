//
//  SEQuestion.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/9/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "Question.h"

/**
 *  Sentence Equivalance Question
 **/
@interface SEQuestion : Question

@property(nonatomic, readwrite, retain) NSArray* options;
@property(nonatomic, readwrite, retain) NSArray* answers;

@end
