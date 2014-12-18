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
    
    SEQuestion* question = [[SEQuestion alloc] init];
    [question setText:@"This is a sample SE Question"];
    
    NSMutableArray* options = [[NSMutableArray alloc] init];
    [options addObject:@"Option 1"];
    [options addObject:@"Option 2"];
    [options addObject:@"Option 3"];
    [options addObject:@"Option 4"];
    [options addObject:@"Option 5"];
    [options addObject:@"Option 6"];
    [options addObject:@"Option 7 is very very very very very very long"];
    [question setOptions:options];
    
    NSMutableArray* answers = [[NSMutableArray alloc] init];
    [answers addObject: [[NSNumber alloc] initWithInteger:0]];
    [answers addObject: [[NSNumber alloc] initWithInteger:1]];
    
    [question setAnswers:answers];
    
    [self setQuestionData:question];
    
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
