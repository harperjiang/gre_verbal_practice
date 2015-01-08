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

#define USER_QUES_PER_SET @"kUserQuestionPerSet"
#define USER_QUES_PER_SET_DEFAULT 10

#define USER_EXAM_TIMELIMIT @"kUserExamTimelimit"
#define USER_EXAM_TIMELIMIT_DEFAULT 30

#define SYS_VERSION_URL @"kSysVersionURL"
#define SYS_VERSION_URL_DEFAULT @"http://www.cocopen.com/gv/version"

#define SYS_DATA_VERSION @"kSysDataVersion"
#define SYS_DATA_VERSION_DEFAULT 0

#define SYS_UPDATE_URL @"kSysUpdateUrl"
#define SYS_UPDATE_URL_DEFAULT @"http://www.cocopen.com/gv/data.json"

#define SYS_VOICE_VERSION @"kSysVoiceVersion"
#define SYS_VOICE_VERSION_DEFAULT 0

#define SYS_VOICE_URL @"kSysVoiceUrl"
#define SYS_VOICE_URL_DEFAULT @"http://www.cocopen.com/gv/voice.zip"

@interface UserPreference : NSObject

+ (NSInteger)getInteger:(NSString*)key defval:(NSInteger)d;
+ (void)setInteger:(NSInteger) value forKey:(NSString*)key;

+ (NSString*)getString:(NSString*)key defval:(NSString*)d;
+ (void)setString:(NSString*)value forKey:(NSString*)key;

@end
