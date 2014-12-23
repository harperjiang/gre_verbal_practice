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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showAnswer {
    [(RCQViewController*)[[self viewControllers] objectAtIndex: 1]
        showAnswers: self.questionData.answers];
}

- (void)setAnswerListener:(id<AnswerListener>)listener {
    [((RCQViewController*)[[self viewControllers] objectAtIndex: 1]).answerView
        setAnswerListener: listener];
}

- (void)setQuestionData:(RCQuestion *)questionData {
    self->_questionData = questionData;
    
    RCAViewController* articleView = (RCAViewController*)[self.viewControllers objectAtIndex:0];
    RCQViewController* questionView = (RCQViewController*)[self.viewControllers objectAtIndex:1];
    [articleView setArticle: [self.questionData.readText toString]];
    [questionView setQuestionData:questionData];
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
