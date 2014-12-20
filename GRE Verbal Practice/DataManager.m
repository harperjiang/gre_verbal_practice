//
//  DataManager.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/16/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "DataManager.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>
#import "MemoryAlgorithm.h"
#import "DateUtils.h"

@implementation DataManager {
    NSArray* seQuestions;
    NSArray* rcQuestions;
    NSArray* tcQuestions;
}

static DataManager* inst;

+ (DataManager*)defaultManager {
    if(nil == inst) {
        inst = [[DataManager alloc] init];
    }
    return inst;
}

- (NSManagedObjectContext*)getContext {
    AppDelegate* app = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    return [app managedObjectContext];
}

- (void)save {
    NSError* error;
    if(![[self getContext] save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

- (void)reset {
    seQuestions = nil;
    rcQuestions = nil;
    tcQuestions = nil;
}

- (NSArray*)query:(NSFetchRequest*)request {
    NSError *error;
    NSArray *array = [[self getContext] executeFetchRequest:request error:&error];
    if (array == nil) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return array;
}

- (NSArray*)getVocabs:(NSInteger)count {
    NSEntityDescription *ed = [NSEntityDescription
                               entityForName:@"Vocabulary"
                               inManagedObjectContext:[self getContext]];
    // Query New words
    NSFetchRequest *newrequest = [[NSFetchRequest alloc] init];
    [newrequest setEntity:ed];
    NSPredicate* predicate = [NSPredicate
                              predicateWithFormat:@"scheduleDate = nil"];
    [newrequest setPredicate: predicate];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"word"
                                        ascending:NO];
    [newrequest setSortDescriptors:@[sortDescriptor]];
    [newrequest setFetchLimit: count];
    NSArray* newarray = [self query:newrequest];
    
    // Query Repeat words
    NSFetchRequest* existrequest = [[NSFetchRequest alloc] init];
    [existrequest setEntity:ed];
    predicate = [NSPredicate predicateWithFormat:@"scheduleDate <= %@", [NSDate date]];
    [existrequest setPredicate:predicate];
    NSArray *existarray = [self query:existrequest];
    
    // Merge two parts;
    NSMutableArray* result = [[NSMutableArray alloc] initWithArray:newarray];
    [result addObjectsFromArray:existarray];
    return result;
}

- (void)updateVocabProgress:(Vocabulary*)vocab {
    vocab.passCount++;
    if(vocab.scheduleDate == nil) {
        vocab.scheduleDate = [DateUtils truncate:[NSDate date]];
    } else {
        NSInteger interval = [MemoryAlgorithm interval:vocab.passCount];
        vocab.scheduleDate = [DateUtils addDate:vocab.scheduleDate date:interval];
    }
    [self save];
}

- (NSArray*)getQuestions:(QuestionType)type count:(NSInteger)count {
    NSArray* source = nil;
    NSString* name = nil;
    switch(type) {
        case SENTENCE_EQUIV:
            source = [self seQuestions];
            name = @"SEQuestion";
            break;
        case READING_COMP:
            source = [self rcQuestions];
            name = @"RCQuestion";
            break;
        case TEXT_COMPLETION:
            source = [self tcQuestions];
            name = @"TCQuestion";
            break;
    }

    NSMutableSet* result = [[NSMutableSet alloc] init];
    
    while(result.count < count) {
        [result addObject:[source objectAtIndex: arc4random() % source.count]];
    }
    
    return [result allObjects];
}

- (NSArray*)seQuestions {
    if(seQuestions == nil) {
        // Re-fetch all SEQuestions
        NSFetchRequest* fetchAll = [[NSFetchRequest alloc] initWithEntityName:@"SEQuestion"];
        seQuestions = [self query:fetchAll];
    }
    return seQuestions;
}

- (NSArray*)rcQuestions {
    if(rcQuestions == nil) {
        // Re-fetch all RCQuestions
        NSFetchRequest* fetchAll = [[NSFetchRequest alloc] initWithEntityName:@"RCQuestion"];
        rcQuestions = [self query:fetchAll];
    }
    return rcQuestions;
}

- (NSArray*)tcQuestions {
    if(tcQuestions == nil) {
        // Re-fetch all TCQuestions
        NSFetchRequest* fetchAll = [[NSFetchRequest alloc] initWithEntityName:@"TCQuestion"];
        tcQuestions = [self query:fetchAll];
    }
    return tcQuestions;
}

@end
