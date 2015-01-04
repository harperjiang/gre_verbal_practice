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
    if(self.answerListener != nil) {
        RCQViewController* qvc = (RCQViewController*)[self.viewControllers objectAtIndex: 1];
        [qvc setAnswerListener: self.answerListener];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showAnswer:(BOOL)show {
    RCQViewController* qvc = (RCQViewController*)[self.viewControllers objectAtIndex: 1];
    [qvc showAnswer:show];
}

- (void)showExplanation:(BOOL)show {
    RCQViewController* qvc = (RCQViewController*)[self.viewControllers objectAtIndex: 1];
    [qvc showExplanation:show];
}

- (void)showChoice:(NSArray *)choice {
    RCQViewController* qvc = (RCQViewController*)[self.viewControllers objectAtIndex: 1];
    [qvc showChoice:choice];
}

- (void)setAnswerListener:(id<AnswerListener>)listener {
    self->_answerListener = listener;
    RCQViewController* qvc = (RCQViewController*)[self.viewControllers objectAtIndex: 1];
    if(qvc != nil) {
        [qvc.answerView setAnswerListener: listener];
    }
}

- (void)setQuestionData:(RCQuestion *)questionData {
    self->_questionData = questionData;
    
    RCAViewController* articleView = (RCAViewController*)[self.viewControllers objectAtIndex:0];
    RCQViewController* questionView = (RCQViewController*)[self.viewControllers objectAtIndex:1];
    [articleView setArticle: [self.questionData.readText toString]];
    [questionView setQuestionData:questionData];
}


@end
