//
//  MemoryAlgorithm.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/18/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "MemoryAlgorithm.h"
#import "DateUtils.h"

int INTERVAL[] = {0,1,2,4,4,7,7,15,21,30};

@implementation MemoryAlgorithm

// 1, 2, 4, 7, 15, 21, 30

+ (void)updateVocab:(Vocabulary*)vocab know:(BOOL)know {
    if(!know) {
        // Start from the beginning
        [vocab setPassCount: [NSNumber numberWithInt:0]];
    } else {
        [vocab setMemoryDate: [DateUtils truncate:[NSDate date]]];
        [vocab setPassCount: [NSNumber numberWithInt: [vocab.passCount intValue] + 1]];
    }
    if(vocab.passCount.intValue >= 10) {
        // No more repeat
        return;
    }
    NSDate* schedule = [DateUtils addDate:[DateUtils truncate:[NSDate date]]
                                     date:INTERVAL[vocab.passCount.intValue]];
    
    [vocab setScheduleDate: schedule];
    
}

@end
