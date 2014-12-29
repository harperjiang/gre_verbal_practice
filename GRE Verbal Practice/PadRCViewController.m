//
//  PadRCViewController.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/22/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "PadRCViewController.h"

@interface PadRCViewController ()

@end

@implementation PadRCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showAnswer {
    [self.answerView setShouldShowAnswer:YES];
}

- (void)setAnswerListener:(id<AnswerListener>)listener {
    [self.answerView setAnswerListener: listener];
}

- (void)setQuestionData:(RCQuestion *)questionData {
    self->_questionData = questionData;
    
    [self.articleTextView setText: [self.questionData.readText toString]];
    [self.questionLabel setText: questionData.text];
    [self.answerView setAnswers: questionData.answers];
    [self.answerView setOptions: questionData.options];
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
