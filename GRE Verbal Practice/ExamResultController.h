//
//  ExamResultViewController.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/17/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExamSuite.h"

@interface ExamResultController : UIViewController

@property(nonatomic, readwrite, strong) ExamSuite* examSuite;

@property(nonatomic, readwrite, strong) IBOutlet UILabel* timeLabel;
@property(nonatomic, readwrite, strong) IBOutlet UILabel* resultLabel;

- (IBAction)reviewExam:(id)sender;

@end
