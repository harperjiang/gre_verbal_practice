//
//  Vocabulary.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/16/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "VocabGroup.h"

@interface Vocabulary: NSManagedObject

@property(nonatomic) VocabGroup* group;
@property(nonatomic) NSString* word;
@property(nonatomic) NSString* explanation;
@property(nonatomic) NSString* synonyms;
@property(nonatomic) NSString* samples;
@property(nonatomic) NSDate* scheduleDate;
@property(nonatomic) NSNumber* passCount;

@end

