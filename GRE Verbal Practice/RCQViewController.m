//
//  RCViewController.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/15/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "RCQViewController.h"
#import "RCViewController.h"

@interface RCQViewController ()

@end

@implementation RCQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if(self.questionData != nil) {
        [self.questionLabel setText: self.questionData.text];
        [self.answerView setOptions: self.questionData.options multiple:self.questionData.multiple];
        [self.answerView setAnswers: self.questionData.answers];
        [self.explainLabel setText: self.questionData.explanation];
        if(self.choice != nil) {
            [self.answerView showChoice:self.choice];
        }
    }
    [self.explainLabel setHidden: !self.shouldShowExplanation];
    
    [self.answerView setAnswerListener:self.answerListener];
    [self.answerView setShouldShowAnswer:self.shouldShowAnswer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setQuestionData:(RCQuestion *)questionData {
    self->_questionData = questionData;
    if(self.questionLabel != nil) {
        [self.questionLabel setText: questionData.text];
        [self.answerView setOptions: questionData.options multiple:questionData.multiple];
        [self.answerView setAnswers: questionData.answers];
        [self.explainLabel setText: self.questionData.explanation];
    }
}

- (void)showAnswer:(BOOL)show {
    self.shouldShowAnswer = show;
    if(self.answerView != nil) {
        [self.answerView setShouldShowAnswer:show];
    }
}

- (void)showExplanation:(BOOL)show {
    self.shouldShowExplanation = show;
    self.explainLabel.hidden = !show;
    [self layout];
}

- (void)showChoice:(NSArray *)choice {
    self.choice = choice;
    if(self.answerView != nil) {
        [self.answerView showChoice:choice];
    }
}

- (void)setAnswerListener:(id<AnswerListener>)answerListener {
    self->_answerListener = answerListener;
    if(self.answerView != nil) {
        [self.answerView setAnswerListener:answerListener];
    }
}

- (void)viewWillLayoutSubviews {
    [self layout];
    [super viewWillLayoutSubviews];
}


- (void)layout {
    CGRect bounds = self.view.bounds;
    
    CGFloat width = bounds.size.width;
    self.viewWidth.constant = width;
    
    // Calculate Title Label height
    
    CGFloat leading = 25;
    CGFloat trailing = 20;
    CGFloat subWidth = width - leading - trailing;
    
    [self.questionLabel setPreferredMaxLayoutWidth: subWidth];
    CGSize preferred = [self.questionLabel sizeThatFits:CGSizeMake(subWidth, 1000)];
    self.questionHeight.constant = preferred.height;
    
    // Calculate Answer View Height
    preferred = [self.answerView sizeThatFits:CGSizeMake(subWidth,0)];
    self.answerHeight.constant = preferred.height;
    
    // Calculate Explanation Label Height
    if(!self.explainLabel.isHidden) {
        [self.explainLabel setPreferredMaxLayoutWidth: subWidth];
        preferred = [self.explainLabel sizeThatFits:CGSizeMake(subWidth, 1000)];
        self.explainHeight.constant = preferred.height;
    } else {
        self.explainHeight.constant = 0;
    }
}

@end
