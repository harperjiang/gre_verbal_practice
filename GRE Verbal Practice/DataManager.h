//
//  DataManager.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/16/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCQuestion.h"
#import "TCQuestion.h"
#import "SEQuestion.h"
#import "Vocabulary.h"


@interface DataManager : NSObject

+ (DataManager*)defaultManager;

- (RCQuestion*)getRCQuestion;
- (TCQuestion*)getTCQuestion;
- (SEQuestion*)getSEQuestion;
- (Vocabulary*)getVocabulary;


@end
