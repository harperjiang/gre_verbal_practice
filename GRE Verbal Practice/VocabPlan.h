//
//  VocabPlan.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/16/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vocabulary.h"
#import "VocabGroup.h"

@interface VocabPlan : NSObject {
    NSMutableArray* source;
    NSMutableArray* dest;
    NSUInteger total;
    NSUInteger current;
    BOOL doneWithToday;
    BOOL doneWithSet;
}

@property(nonatomic, readwrite, strong) NSDate* date;
@property(nonatomic, readwrite, strong) NSArray* words;
@property(nonatomic, readwrite, strong) VocabGroup* group;

+ (VocabPlan*)create:(VocabGroup*)group;

- (Vocabulary*)nextVocab;
- (NSString*)status;
- (void)feedback:(BOOL)know;

- (BOOL)doneWithToday;
- (BOOL)doneWithSet;

@end
