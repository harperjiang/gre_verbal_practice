//
//  Vocabulary.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/16/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Vocabulary : NSObject

@property(nonatomic, readwrite, retain) NSString* word;
@property(nonatomic, readwrite, retain) NSString* explanation;
@property(nonatomic, readwrite, retain) NSString* synonyms;
@property(nonatomic, readwrite, retain) NSString* samples;

@end
