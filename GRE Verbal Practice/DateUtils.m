//
//  DateUtils.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/18/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "DateUtils.h"

@implementation DateUtils

+ (NSDate*)truncate:(NSDate*) input {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps =
    [gregorian components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:input];
    return [gregorian dateFromComponents:comps];
}


+ (NSDate*)addDate:(NSDate*)source date:(NSInteger)d {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps =
    [gregorian components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:source];
    [comps setDay:comps.day + d];
    return [gregorian dateFromComponents:comps];
}

+ (NSString*)format:(long)remain {
    long hour = remain / 3600;
    remain = remain % 3600;
    long minute = remain / 60;
    long second = remain % 60;
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld", hour, minute, second];
}

@end
