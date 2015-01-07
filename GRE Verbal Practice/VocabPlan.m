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
#import "MemoryAlgorithm.h"

@implementation VocabPlan

+ (VocabPlan*)create:(VocabGroup*)group {
    NSInteger dailyCount = [UserPreference getInteger: USER_DAILY_VOCAB
                                               defval: USER_DAILY_VOCAB_DEFAULT];
    DataManager* dm = [DataManager defaultManager];
    NSArray* words = [dm getVocabs:dailyCount ingroup:group];
    
    VocabPlan* newplan = [[VocabPlan alloc] init];
    newplan.group = group;
    if(words.count == 0) {
        NSInteger totalVocab = [dm getVocabCount:group];
        if(totalVocab == 0)
            return nil;
        newplan->doneWithToday = YES;
        NSInteger futureVocab = [dm getFutureVocabCount:group];
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
    return [NSString stringWithFormat: @"This round: %zd/%zd", total - source.count, total];
}

- (void)feedback:(BOOL)know {
    if(source == nil || source.count == 0)
        return;
    Vocabulary* cv = [self->source objectAtIndex:current];
    // Update Vocabulary Status into persistent store
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        DataManager* dm = [DataManager defaultManager];
        [MemoryAlgorithm updateVocab: cv know:know];
        [dm save];
        NSInteger vocabcount = [dm getVocabCount:self.group];
        NSInteger vocabFuture = [dm getDoneVocabCount:self.group];
        self.group.detail = [NSString stringWithFormat:@"Progress: %zd/%zd",vocabFuture,vocabcount];
        [dm save];
    });
    
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
