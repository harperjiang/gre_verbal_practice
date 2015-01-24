//
//  ExamResultViewController.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/17/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "ExamResultController.h"
#import "ExamViewController.h"
#import "DateUtils.h"
#import "DataManager.h"
#import "UIUtils.h"
#import "Scorer.h"

@interface ExamResultController ()

@end

@implementation ExamResultController

- (BOOL)isPad {
#ifdef UI_USER_INTERFACE_IDIOM
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
#else
    return NO;
#endif
}

- (NSString*)diffcultyName:(NSInteger)diffculty {
    switch (diffculty) {
        case 0:
            return @"Hard";
        case 1:
            return @"Normal";
        case 2:
            return @"Easy";
        default:
            return @"";
    }
}

- (void)viewDidLoad {
    self.view.backgroundColor = [UIUtils backgroundColor];
    
    // Display Exam Result
    long totalTime = self.examSuite.timeLimit.intValue * 60;
    long usedTime = self.examSuite.timeLimit.intValue * 60 - self.examSuite.timeRemain;
    
    [self.timeLabel setText: [DateUtils format: usedTime]];
    
    Score* score = [self.examSuite score];
    [self.resultLabel setText: [score scoreText]];
    
    NSInteger diffculty = 1;
    [self.diffcultyLabel setText: [self diffcultyName:diffculty]];
    
    NSNumber* timePercent = [NSNumber numberWithDouble: ((double)usedTime) / totalTime];
    _grade = [ExamGrader grade: score.scoreValue time: timePercent diffculty: diffculty];
    
    NSString* grade = [_grade grade];
    
    // Setup Charts
    self.pieChartView.dataSource = self;
    [self.gradeView setGrade: grade];
    
    // Update Statistics
    self.examSuite.statistics = [NSString stringWithFormat:@"Grade: %@, Time used: %@, result %@",
                                 grade, self.timeLabel.text, self.resultLabel.text];
    [[DataManager defaultManager] save];
}

- (void)viewWillLayoutSubviews {
    self.containerWidth.constant = [self.view bounds].size.width;
}

- (IBAction)reviewExam:(id)sender {
    ExamViewController* evc = (ExamViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"ExamViewController"];
    [evc setReviewMode: YES];
    [evc setExamSuite: self.examSuite];
    
    UINavigationController* navController = self.navigationController;
    NSMutableArray *controllers= [[NSMutableArray alloc] initWithArray:navController.viewControllers];
    UIViewController* last = [controllers lastObject];
    [last willMoveToParentViewController:nil];
    [controllers removeLastObject];
    [navController setViewControllers:controllers];
    [last removeFromParentViewController];
    [last didMoveToParentViewController:nil];
    [navController pushViewController: evc animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    return;
}

- (NSInteger)numOfSections {
    return 3;
}

- (double)percentOfSection:(NSInteger)section {
    switch(section) {
        case 0:
            return _grade.diffcultyWeight.doubleValue;
        case 1:
            return _grade.correctnessWeight.doubleValue;
        case 2:
            return _grade.timeWeight.doubleValue;
        default:
            return 0;
    }
}

- (NSString *)titleOfSection:(NSInteger)section {
    switch(section) {
        case 0:
            return [NSString stringWithFormat: @"Diffculty Grade: %@", _grade.diffcultyGrade];
        case 1:
            return [NSString stringWithFormat: @"Correctness Grade: %@", _grade.correctnessGrade];
        case 2:
            return [NSString stringWithFormat: @"Time Grade: %@", _grade.timeGrade];
        default:
            return @"";
    }
}

@end
