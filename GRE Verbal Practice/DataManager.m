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

- (BOOL)save {
    NSError* error;
    if(![[self getContext] save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        return NO;
    }
    return YES;
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
        return nil;
    }
    return array;
}

- (NSInteger)count:(NSFetchRequest*)request {
    NSError *error;
    NSInteger res = [[self getContext] countForFetchRequest:request error:&error];
    if (res == NSNotFound) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        return -1;
    }
    return res;
}

- (void)deleteAll {
    [self deleteAll:@"Vocabulary"];
    [self deleteAll:@"SEQuestion"];
    [self deleteAll:@"RCQuestion"];
    [self deleteAll:@"RCText"];
    [self deleteAll:@"TCQuestion"];
    [self deleteAll:@"QuestionSet"];
    [self deleteAll:@"VocabGroup"];
    [self deleteAll:@"ExamSuite"];
}

- (void)deleteAll:(NSString *)type {
    NSManagedObjectContext *deleteContext = [self getContext];
    
    // Each call to performBlock executes in its own autoreleasepool, so we don't
    // need to explicitly use one if each chunk is done in a separate performBlock
    while(true) {
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:type];//
        // Only fetch the number of objects to delete this iteration
        fetchRequest.fetchLimit = 100;
        // Prefetch all the relationships;
        // TODO Not doing this now
        // Don't need all the properties
        fetchRequest.includesPropertyValues = NO;
        
        NSError* error;
        NSArray *results = [deleteContext executeFetchRequest:fetchRequest error:&error];
        if (results.count == 0) {
            // Didn't get any objects for this fetch
            if (nil == results) {
                // Handle error
                NSLog(@"Error:%@,%@",error,[error userInfo]);
            }
            break;
        }
        for (NSManagedObject *entity in results) {
            [deleteContext deleteObject:entity];
        }
        
        if(![deleteContext save:&error]) {
            NSLog(@"Error:%@,%@",error,[error userInfo]);
        }
        [deleteContext reset];
    }
}

- (NSArray*)getVocabGroups {
    NSFetchRequest* fr = [[NSFetchRequest alloc] initWithEntityName:@"VocabGroup"];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"name" ascending:YES];
    [fr setSortDescriptors:@[sort]];
    
    return [self query:fr];
}

- (NSArray*)getVocabs:(NSInteger)count ingroup:(VocabGroup *)group {
    NSEntityDescription *ed = [NSEntityDescription
                               entityForName:@"Vocabulary"
                               inManagedObjectContext:[self getContext]];
    // Query New words
    NSFetchRequest *newrequest = [[NSFetchRequest alloc] init];
    [newrequest setEntity:ed];
    NSPredicate* datePredicate = [NSPredicate
                              predicateWithFormat:@"scheduleDate = nil"];
    NSPredicate* groupPredicate = [NSPredicate predicateWithFormat:@"group = %@", group];
    [newrequest setPredicate: [NSCompoundPredicate andPredicateWithSubpredicates:
                                    @[datePredicate, groupPredicate]]];
    
//    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
//                                        initWithKey:@"word"
//                                        ascending:NO];
//    [newrequest setSortDescriptors:@[sortDescriptor]];
    [newrequest setFetchLimit: count];
    NSArray* newarray = [self query:newrequest];
    
    // Query Repeat words
    NSFetchRequest* existrequest = [[NSFetchRequest alloc] init];
    [existrequest setEntity:ed];
    datePredicate = [NSPredicate predicateWithFormat:@"scheduleDate < %@", [DateUtils truncate:[NSDate date]]];
    [existrequest setPredicate:
     [NSCompoundPredicate andPredicateWithSubpredicates:@[datePredicate, groupPredicate]]];
    NSArray *existarray = [self query:existrequest];
    
    // Merge two parts;
    NSMutableArray* result = [[NSMutableArray alloc] initWithArray:newarray];
    [result addObjectsFromArray:existarray];
    return result;
}

- (NSInteger)getDoneVocabCount:(VocabGroup*)group {
    NSFetchRequest* fr = [[NSFetchRequest alloc] initWithEntityName:@"Vocabulary"];
    NSPredicate* datePredicate = [NSPredicate predicateWithFormat:@"scheduleDate <= %@", [DateUtils truncate:[NSDate date]]];
    NSPredicate* groupPredicate = [NSPredicate predicateWithFormat:@"group = %@", group];
    [fr setPredicate: [NSCompoundPredicate andPredicateWithSubpredicates:@[datePredicate, groupPredicate]]];
    return [self count:fr];
}

- (NSInteger)getFutureVocabCount:(VocabGroup*)group {
    NSFetchRequest* fr = [[NSFetchRequest alloc] initWithEntityName:@"Vocabulary"];
    NSPredicate* datePredicate = [NSPredicate predicateWithFormat:@"scheduleDate > %@", [DateUtils truncate:[NSDate date]]];
    NSPredicate* groupPredicate = [NSPredicate predicateWithFormat:@"group = %@", group];
    [fr setPredicate: [NSCompoundPredicate andPredicateWithSubpredicates:@[datePredicate, groupPredicate]]];
    return [self count:fr];
}

- (NSInteger)getVocabCount:(VocabGroup*)group {
    NSFetchRequest* fr = [[NSFetchRequest alloc] initWithEntityName:@"Vocabulary"];
    NSPredicate* groupPredicate = [NSPredicate predicateWithFormat:@"group = %@", group];
    [fr setPredicate:groupPredicate];
    return [self count:fr];
}

- (NSArray*)getExamSuites {
    NSFetchRequest* fr = [[NSFetchRequest alloc] initWithEntityName:@"ExamSuite"];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"name" ascending:YES];
    [fr setSortDescriptors:@[sort]];
    
    return [self query:fr];
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

    if(source == nil || source.count == 0)
        return [[NSArray alloc] init];
    NSMutableSet* result = [[NSMutableSet alloc] init];
    
    while(result.count < MIN(count, source.count)) {
        [result addObject:[source objectAtIndex: arc4random() % source.count]];
    }
    
    return [result allObjects];
}

- (NSArray*)getQuestionSets:(QuestionType)type {
    
    NSFetchRequest* fr = [[NSFetchRequest alloc] initWithEntityName:@"QuestionSet"];
    
    NSPredicate* condition = [NSPredicate predicateWithFormat:@"rawType = %ld",type];
    [fr setPredicate:condition];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"name" ascending:YES];
    [fr setSortDescriptors:@[sort]];
    
    return [self query:fr];
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
