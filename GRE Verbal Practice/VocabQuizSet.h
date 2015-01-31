//
//  VocabQuizSet.h
//  GRE Verbal Master
//
//  Created by Harper on 1/30/15.
//  Copyright (c) 2015 Hao Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VocabQuiz.h"

@interface VocabQuizSet : NSObject {
    NSInteger _index;
    NSInteger _correct;
}

@property(nonatomic) NSArray* questions;
@property(nonatomic) NSMutableArray* answers;
@property(nonatomic) NSInteger score;

+ (VocabQuizSet*)create;

- (NSInteger)size;
- (NSInteger)correct;
- (VocabQuiz*)current;
- (NSInteger)index;
- (BOOL)next;
- (NSInteger)answer:(NSInteger)answer;
@end
