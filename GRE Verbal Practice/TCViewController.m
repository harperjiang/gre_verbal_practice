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
    
    // Demo Data
    TCQuestion* question = [[TCQuestion alloc] init];
    
    [question setText:@"This is a sample question"];
    
    NSMutableArray* optionsArray = [[NSMutableArray alloc] init];
    
    NSMutableArray* option1Array = [[NSMutableArray alloc] init];
    [optionsArray addObject: option1Array];
    
    [option1Array addObject:@"Option 1"];
    [option1Array addObject:@"Option 2"];
    
    NSMutableArray* option2Array = [[NSMutableArray alloc] init];
    [option2Array addObject:@"Option 3"];
    [option2Array addObject:@"Option 4"];
    [optionsArray addObject:option2Array];
    
    [question setOptions:optionsArray];
    
    NSMutableArray* answers = [[NSMutableArray alloc] init];
    [answers addObject: [[NSNumber alloc] initWithInteger:0]];
    [answers addObject: [[NSNumber alloc] initWithInteger:1]];
    [question setAnswers: answers];
    
    [self setQuestionData: question];
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
