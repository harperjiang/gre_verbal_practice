//
//  Vocabulary.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/16/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Vocabulary: NSManagedObject

@property(nonatomic, readwrite, strong) NSString* word;
@property(nonatomic, readwrite, strong) NSString* explanation;
@property(nonatomic, readwrite, strong) NSString* synonyms;
@property(nonatomic, readwrite, strong) NSString* samples;

@property(nonatomic, readwrite, strong) NSDate* scheduleDate;
@property(nonatomic, readwrite) NSInteger passCount;

@end

