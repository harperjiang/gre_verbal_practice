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
        RCAViewController* qva = (RCAViewController*)[self.viewControllers objectAtIndex: 0];
        [qva setAnswerListener: self.answerListener];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showChoice:(NSArray *)choice {
    if(self.questionData.selectSentence) {
        RCAViewController* qva = (RCAViewController*)[self.viewControllers objectAtIndex: 0];
        [qva showChoice:choice];
    } else {
        RCQViewController* qvc = (RCQViewController*)[self.viewControllers objectAtIndex: 1];
        [qvc showChoice:choice];
    }
}

- (void)showAnswerWithChoice:(NSArray *)choice {
    if(self.questionData.selectSentence) {
        RCAViewController* qva = (RCAViewController*)[self.viewControllers objectAtIndex: 0];
        [qva showAnswerWithChoice:choice];
    } else {
        RCQViewController* qvc = (RCQViewController*)[self.viewControllers objectAtIndex: 1];
        [qvc showAnswerWithChoice:choice];
    }
}

- (void)hideAnswer {
    if(self.questionData.selectSentence) {
        RCAViewController* qva = (RCAViewController*)[self.viewControllers objectAtIndex: 0];
        [qva hideAnswer];
    } else {
        RCQViewController* qvc = (RCQViewController*)[self.viewControllers objectAtIndex: 1];
        [qvc hideAnswer];
    }
}

- (void)showExplanation:(BOOL)show {
    RCQViewController* qvc = (RCQViewController*)[self.viewControllers objectAtIndex: 1];
    [qvc showExplanation:show];
}

- (void)setAnswerListener:(id<AnswerListener>)listener {
    self->_answerListener = listener;
    RCAViewController* qva = (RCAViewController*)[self.viewControllers objectAtIndex: 0];
    if(qva != nil) {
        [qva setAnswerListener: listener];
    }
    RCQViewController* qvc = (RCQViewController*)[self.viewControllers objectAtIndex: 1];
    if(qvc != nil) {
        [qvc setAnswerListener: listener];
    }
}

- (void)setQuestionData:(RCQuestion *)questionData {
    self->_questionData = questionData;
    
    RCAViewController* articleView = (RCAViewController*)[self.viewControllers objectAtIndex:0];
    RCQViewController* questionView = (RCQViewController*)[self.viewControllers objectAtIndex:1];
    [articleView setQuestionData: questionData];
    [questionView setQuestionData: questionData];
}


@end
