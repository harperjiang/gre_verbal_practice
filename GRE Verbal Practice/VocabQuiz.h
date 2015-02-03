//
//  VocabQuiz.h
//  GRE Verbal Master
//
//  Created by Harper on 1/30/15.
//  Copyright (c) 2015 Hao Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VocabQuizSet;

@interface VocabQuiz : NSObject

@property(nonatomic) NSInteger difficulty;
@property(nonatomic) NSString* question;
@property(nonatomic) NSArray* options;
@property(nonatomic) NSInteger answer;
@property(nonatomic) NSString* explanation;

@property(nonatomic) VocabQuizSet* header;


@end
