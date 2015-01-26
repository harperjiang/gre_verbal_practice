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
        if(!self.questionData.selectSentence) {
            [self.answerView setAnswers: self.questionData.answers];
            if(self.choice != nil) {
                [self.answerView showChoice:self.choice];
            }
        }
        if(self.shouldShowAnswer)
            [self judgeAndShowImage];
        [self.explainLabel setText: self.questionData.explanation];
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
        if(!questionData.selectSentence) {
            [self.answerView setAnswers: questionData.answers];
        }
        [self.explainLabel setText: self.questionData.explanation];
    }
}

- (void)showChoice:(NSArray *)choice {
    self.choice = choice;
    [self.answerView showChoice:choice];
}

- (void)showAnswerWithChoice:(NSArray *)choice {
    [self setShouldShowAnswer:YES];
    [self showChoice:choice];
    if(self.answerView != nil) {
        [self.answerView setShouldShowAnswer:YES];
        [self.answerView setAnswerListener: nil];
        
    }
    [self judgeAndShowImage];
}

- (void)hideAnswer {
    [self setShouldShowAnswer:NO];
    if(self.answerView != nil) {
        [self.answerView setShouldShowAnswer:NO];
        [self.answerView setAnswerListener:self.answerListener];
    }
    self.resultImageView.hidden = YES;
    self.resultLabel.hidden = YES;
    self.resultPercentView.hidden = YES;
}

- (void)showExplanation:(BOOL)show {
    self.shouldShowExplanation = show;
    self.explainLabel.hidden = !show;
    [self layout];
}

- (void)judgeAndShowImage {
    NSString* imageName = [self.questionData verifyAnswer:self.choice]?@"Vocab_Yes":@"Vocab_No";
    UIImage* image = [UIImage imageNamed:imageName];
    [self.resultImageView setImage:image];
    self.resultImageView.hidden = NO;
    
//    self.resultLabel.hidden = NO;
//    self.resultPercentView.hidden = NO;
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
