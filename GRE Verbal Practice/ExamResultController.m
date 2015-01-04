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

@interface ExamResultController ()

@end

@implementation ExamResultController

- (void)viewDidLoad {
    
    self.view.backgroundColor = [UIUtils backgroundColor];
    
    // Display Exam Result
    [self.timeLabel setText: [DateUtils format: self.examSuite.timeLimit * 60
                              - self.examSuite.timeRemain]];
    [self.resultLabel setText: [self.examSuite score]];
    
    self.examSuite.statistics = [NSString stringWithFormat:@"Time used: %@, result %@",
                                 self.timeLabel.text, self.resultLabel.text];
    [[DataManager defaultManager] save];
}


- (IBAction)reviewExam:(id)sender {
    ExamViewController* evc = (ExamViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"ExamViewController"];
    [evc setReviewMode: YES];
    [evc setExamSuite: self.examSuite];
    
    UINavigationController* navController = self.navigationController;
    NSMutableArray *controllers=[[NSMutableArray alloc] initWithArray:navController.viewControllers] ;
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

@end
