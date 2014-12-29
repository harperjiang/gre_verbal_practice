//
//  ExamResultViewController.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/17/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "ExamResultController.h"
#import "ExamViewController.h"

@interface ExamResultController ()

@end

@implementation ExamResultController


- (IBAction)reviewExam:(id)sender {
    
    ExamViewController* evc = (ExamViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"ExamViewController"];
    [evc setReviewMode: YES];
    [evc setExamSuite: self.examSuite];
    
    UINavigationController* navController = self.navigationController;
    NSMutableArray *controllers=[[NSMutableArray alloc] initWithArray:navController.viewControllers] ;
    [controllers removeLastObject];
    [navController setViewControllers:controllers];
    [navController pushViewController: evc animated:YES];
}

@end
