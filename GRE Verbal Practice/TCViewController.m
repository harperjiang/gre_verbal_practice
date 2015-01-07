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
    if(self.questionData != nil) {
        [self.questionLabel setText: self.questionData.text];
        [self.answerView setOptions: self.questionData.options];
        [self.answerView setAnswers: self.questionData.answers];
        [self.explainLabel setText: self.questionData.explanation];
    }
    if(self.answerListener != nil) {
        [self.answerView setAnswerListener:self.answerListener];
    }
}

- (void)viewWillLayoutSubviews {
    [self layout];
    [super viewWillLayoutSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) setQuestionData:(TCQuestion *)questionData {
    self->_questionData = questionData;
    if(self.questionLabel != nil) {
        [self.questionLabel setText: self.questionData.text];
        [self.answerView setOptions: self.questionData.options];
        [self.answerView setAnswers: self.questionData.answers];
        [self.explainLabel setText: self.questionData.explanation];
    }
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
    //    CGSize preferred2 = [self.questionLabel systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    self.questionHeight.constant = preferred.height;
    
    // Calculate Answer View Height
    preferred = [self.answerView sizeThatFits:CGSizeMake(subWidth,0)];
    self.answerHeight.constant = preferred.height;
    
    // Calculate Explanation Label Height
    if(!self.explainLabel.isHidden) {
        [self.explainLabel setPreferredMaxLayoutWidth: subWidth];
        CGSize preferred = [self.explainLabel sizeThatFits:CGSizeMake(subWidth,1000)];
        self.explainHeight.constant = preferred.height;
    } else {
        self.explainHeight.constant = 0;
    }
    
}

- (void)showChoice:(NSArray *)choice {
    self.choice = choice;
    [self.answerView showChoice:choice];
}

- (void)showAnswerWithChoice:(NSArray *)choice {
    [self.answerView setShouldShowAnswer: YES];
    [self showChoice:choice];
    // Only listen to answerchange when not showing answer
    [self.answerView setAnswerListener:nil];
    [self judgeAndShowImage];
}

- (void)hideAnswer {
    [self.answerView setShouldShowAnswer:NO];
    [self.answerView setAnswerListener:self.answerListener];
    self.resultImageView.hidden = YES;
}

- (void)showExplanation:(BOOL)show {
    [self.explainLabel setHidden:!show];
    [self layout];
}

- (void)setAnswerListener:(id<AnswerListener>)listener {
    self->_answerListener = listener;
    if(self.answerView != nil && self.answerView.shouldShowAnswer) {
        [self.answerView setAnswerListener:listener];
    }
}

- (void)judgeAndShowImage {
    NSString* imageName = [self.questionData verifyAnswer:self.choice]?@"Vocab_Yes":@"Vocab_No";
    UIImage* image = [UIImage imageNamed:imageName];
    [self.resultImageView setImage:image];
    self.resultImageView.hidden = NO;
}

@end
