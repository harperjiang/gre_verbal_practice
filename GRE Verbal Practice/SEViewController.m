//
//  SEViewController.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/15/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "SEViewController.h"

@interface SEViewController ()

@end

@implementation SEViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setQuestionData:(SEQuestion *)questionData {
    self->_questionData = questionData;
    [self.questionLabel setText:questionData.text];
    [self.answerView setOptions: questionData.options];
}

- (void)showAnswer {
    [self.answerView showAnswer: self.questionData.answers];
}

- (void)setAnswerListener:(id<AnswerListener>)listener {
    [self.answerView setAnswerListener:listener];
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
