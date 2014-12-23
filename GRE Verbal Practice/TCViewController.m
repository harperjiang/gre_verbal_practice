//
//  TCViewController.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/9/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "TCViewController.h"

@interface TCViewController ()

@end

@implementation TCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) setQuestionData:(TCQuestion *)questionData {
    self->_questionData = questionData;
    if(self.questionData != nil) {
        [self.questionLabel setText: self.questionData.text];
        [self.answerView setOptions: self.questionData.options];
    }
}

- (void)showAnswer {
    [self.answerView showAnswer: self.questionData.answers];
}

- (void)setAnswerListener:(id<AnswerListener>)listener {
    [self.answerView setAnswerListener:listener];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
