//
//  RCViewController.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/15/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "RCViewController.h"
#import "RCAViewController.h"
#import "RCQViewController.h"

@interface RCViewController ()

@end

@implementation RCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    RCQuestion* question = [[RCQuestion alloc] init];
    [question setText:@"The passage addresses which of the following issues related to Glass's use of popular elements in his classical compositions?"];
    NSMutableArray* options = [[NSMutableArray alloc] init];
    [options addObject:@"How it is regarded by listeners who prefer rock to the classics"];
    [options addObject:@"How it has affected the commercial success of Glass's music"];
    [options addObject:@"Whether it has contributed to a revival of interest among other composers in using popular elements in their compositions"];
    [options addObject:@"Whether it has had a detrimental effect on Glass's reputation as a composer of classical music"];
    [options addObject:@"Whether it has caused certain of Glass's works to be derivative in quality"];
    [question setOptions:options];
    
    NSMutableArray* answers = [[NSMutableArray alloc] init];
    [answers addObject: [[NSNumber alloc] initWithInteger: 0]];
    
    [question setAnswers:answers];
    
    [self setQuestionData:question];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showAnswer {
    [(RCQViewController*)[[self viewControllers] objectAtIndex: 1]
        showAnswers: self.questionData.answers];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
