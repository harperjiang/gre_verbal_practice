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


@end
