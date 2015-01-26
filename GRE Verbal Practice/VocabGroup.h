//
//  VocabSet.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/30/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface VocabGroup : NSManagedObject

@property(nonatomic) NSString* uid;
@property(nonatomic) NSString* name;
@property(nonatomic) NSString* detail;
@property(nonatomic) NSSet* vocabularies;

@end
