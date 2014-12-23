//
//  VocabPlan.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/16/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "VocabPlan.h"
#import "DataManager.h"
#import "UserPreference.h"

@implementation VocabPlan

+ (VocabPlan*)create{
    NSInteger dailyCount = [UserPreference getInteger:USER_DAILY_VOCAB defval: USER_DAILY_VOCAB_DEFAULT];
    DataManager* dm = [DataManager defaultManager];
    NSArray* words = [dm getVocabs:dailyCount];
    
    
    VocabPlan* newplan = [[VocabPlan alloc] init];
    
    if(words.count == 0) {
        NSInteger totalVocab = [dm getVocabCount];
        if(totalVocab == 0)
            return nil;
        newplan->doneWithToday = YES;
        NSInteger futureVocab = [dm getFutureVocabCount];
        if(futureVocab == 0) {
            newplan->doneWithSet = YES;
        }
    } else {
        [newplan setWords:words];
    }
    return newplan;
}

- (Vocabulary*)nextVocab {
    if(source == nil) {
        // Init
        source = [[NSMutableArray alloc] initWithArray: self.words];
        total = source.count;
        dest = [[NSMutableArray alloc] init];
        self.words = source;
    }
    if(source.count == 0 && dest.count == 0) {
        return nil;
    }
    if(source.count == 0 && dest.count != 0) {
        source = dest;
        dest = (NSMutableArray*)self.words;
        self.words = source;
        total = source.count;
    }
    current = arc4random() % source.count;
    return [self->source objectAtIndex: current];
}

- (NSString*)status {
    return [NSString stringWithFormat: @"This round: %ld/%ld", (long)source.count,(long)total];
}

- (void)feedback:(BOOL)know {
    if(source == nil || source.count == 0)
        return;
    Vocabulary* cv = [self->source objectAtIndex:current];
    [self->source removeObjectAtIndex:current];
    if(!know) {
        [self->dest addObject:cv];
    }
}

- (BOOL)doneWithToday {
    return doneWithToday;
}

- (BOOL)doneWithSet {
    return doneWithSet;
}

@end
