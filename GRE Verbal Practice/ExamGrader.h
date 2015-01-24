//
//  ExamGrader.h
//  GRE Verbal Master
//
//  Created by Harper on 1/23/15.
//  Copyright (c) 2015 Hao Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExamGrade : NSObject

@property(nonatomic) NSString* grade;

@property(nonatomic) NSString* timeGrade;
@property(nonatomic) NSString* correctnessGrade;
@property(nonatomic) NSString* diffcultyGrade;

@property(nonatomic) NSNumber* timeWeight;
@property(nonatomic) NSNumber* correctnessWeight;
@property(nonatomic) NSNumber* diffcultyWeight;

@end


@interface ExamGrader : NSObject

+ (ExamGrade*)grade:(NSNumber*)correct time:(NSNumber*)time diffculty:(NSInteger)diffculty;

@end
