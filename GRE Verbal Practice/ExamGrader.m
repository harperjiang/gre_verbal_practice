//
//  ExamGrader.m
//  GRE Verbal Master
//
//  Created by Harper on 1/23/15.
//  Copyright (c) 2015 Hao Jiang. All rights reserved.
//

#import "ExamGrader.h"

@implementation ExamGrade

@end

@implementation ExamGrader

+ (ExamGrade *)grade:(NSNumber *)correct time:(NSNumber *)time difficulty:(NSInteger)difficulty {
    // TODO
    ExamGrade* grade = [[ExamGrade alloc] init];
    
    grade.difficultyWeight = [NSNumber numberWithDouble:0.25];
    grade.correctnessWeight = [NSNumber numberWithDouble:0.4];
    grade.timeWeight = [NSNumber numberWithDouble:0.35];

    double timeScore = 0;
    if(time.doubleValue <= 0.67) {
        timeScore = 100;
    } else {
        timeScore = 100 - 20*(time.doubleValue - 0.67)/0.11;
    }
    grade.timeGrade = [self scoreToGrade:timeScore];
    
    double difficultyScore = 100 - difficulty * 12;
    grade.difficultyGrade = [self scoreToGrade:difficultyScore];
    
    
    double correctnessScore = 100 * correct.doubleValue;
    grade.correctnessGrade = [self scoreToGrade:correctnessScore];
    
    double total = timeScore * grade.timeWeight.doubleValue +
                   difficultyScore * grade.difficultyWeight.doubleValue +
                   correctnessScore * grade.correctnessWeight.doubleValue;
    
    grade.grade = [self scoreToGrade:total];
    return grade;
}

+ (NSString*)scoreToGrade:(double)score {
    if(score >= 90) {
        return @"A";
    }
    if(score >= 80) {
        return @"B";
    }
    if(score >= 70) {
        return @"C";
    }
    if(score >= 60) {
        return @"D";
    }
    return @"F";
}

@end
