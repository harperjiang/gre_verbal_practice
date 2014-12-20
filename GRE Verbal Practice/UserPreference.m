//
//  UserPreference.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/18/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "UserPreference.h"

@implementation UserPreference

+ (NSInteger)getInteger:(NSString*)key defval:(NSInteger)defval {
    NSNumber* num = (NSNumber*)[[NSUserDefaults standardUserDefaults] objectForKey:key];
    if(nil == num) {
        return defval;
    }
    return [num integerValue];
}

+ (void)setInteger:(NSInteger) value forKey:(NSString*)key {
    NSNumber* num = [[NSNumber alloc] initWithInteger:value];
    [[NSUserDefaults standardUserDefaults] setObject:num forKey:key];
}

@end
