//
//  Scorer.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/19/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Scorer : NSObject

+ (NSString*)score:(NSArray*)questions answer:(NSArray*)answers;
+ (NSString*)scoreWithSet:(NSOrderedSet*)questions answer:(NSArray*)answers;

@end
