//
//  MemoryAlgorithm.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/18/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "MemoryAlgorithm.h"

@implementation MemoryAlgorithm

+ (NSInteger)interval:(NSInteger)count {
    return arc4random()%(count*4);
}

@end
