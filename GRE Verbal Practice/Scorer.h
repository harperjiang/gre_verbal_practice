//
//  Scorer.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/19/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Score : NSObject

@property(nonatomic) NSInteger total;
@property(nonatomic) NSInteger correct;

- (NSString*)scoreText;
- (NSNumber*)scoreValue;

@end

@interface Scorer : NSObject

+ (Score*)score:(NSArray*)questions answer:(NSArray*)answers;
+ (Score*)scoreWithSet:(NSOrderedSet*)questions answer:(NSArray*)answers;

@end
