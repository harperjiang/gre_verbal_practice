//
//  VocabPlan.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/16/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vocabulary.h"

@interface VocabPlan : NSObject {
    NSMutableArray* source;
    NSMutableArray* dest;
    NSUInteger current;
}

@property(nonatomic, readwrite, strong) NSDate* date;
@property(nonatomic, readwrite, strong) NSArray* words;

+ (VocabPlan*)create;

- (Vocabulary*)nextVocab;
- (NSString*)status;
- (void)feedback:(BOOL)know;

@end
