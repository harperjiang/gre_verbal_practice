//
//  DateUtils.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/18/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtils : NSObject

+ (NSDate*)truncate:(NSDate*) input;
+ (NSDate*)addDate:(NSDate*)source date:(NSInteger)d;
+ (NSString*)format:(long)seconds;
@end
