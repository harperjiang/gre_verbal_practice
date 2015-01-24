//
//  ExamResultViewController.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/17/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExamSuite.h"
#import "PieChartView.h"
#import "ExamGrader.h"
#import "GradeView.h"

@interface ExamResultController : UIViewController<PieChartDataSource> {
    ExamGrade* _grade;
}

@property(nonatomic, readwrite, strong) ExamSuite* examSuite;

@property(nonatomic) IBOutlet NSLayoutConstraint* containerWidth;
@property(nonatomic) IBOutlet PieChartView* pieChartView;
@property(nonatomic) IBOutlet GradeView* gradeView;

@property(nonatomic, readwrite, strong) IBOutlet UILabel* timeLabel;
@property(nonatomic, readwrite, strong) IBOutlet UILabel* resultLabel;
@property(nonatomic, readwrite, strong) IBOutlet UILabel* diffcultyLabel;

- (IBAction)reviewExam:(id)sender;

@end
