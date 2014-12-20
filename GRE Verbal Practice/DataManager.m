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

@implementation DataManager

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


@end
