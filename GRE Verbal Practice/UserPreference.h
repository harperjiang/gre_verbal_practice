//
//  UserPreference.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/18/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define USER_DAILY_VOCAB @"kUserDailyVocab"
#define USER_DAILY_VOCAB_DEFAULT 30

@interface UserPreference : NSObject

+ (NSInteger)getInteger:(NSString*)key defval:(NSInteger)d;
+ (void)setInteger:(NSInteger) value forKey:(NSString*)key;

@end
