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
    
    if(self.questionData != nil) {
        [self.questionLabel setText: self.questionData.text];
        [self.answerView setOptions: self.questionData.options];
        [self.answerView setAnswers: self.questionData.answers];
        [self.explanationLabel setText: self.questionData.explanation];
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
    self.titleHeight.constant = preferred.height;
    
    // Calculate Answer View Height
    preferred = [self.answerView sizeThatFits:CGSizeMake(subWidth,0)];
    self.answerHeight.constant = preferred.height;
    
    // Calculate Explanation Label Height
    if(!self.explanationLabel.isHidden) {
        [self.explanationLabel setPreferredMaxLayoutWidth: subWidth];
        CGSize preferred = [self.explanationLabel sizeThatFits:CGSizeMake(subWidth, 1000)];
        self.explainHeight.constant = preferred.height;
    } else {
        self.explainHeight.constant = 0;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setQuestionData:(SEQuestion *)questionData {
    self->_questionData = questionData;
    if(self.questionLabel != nil) {
        [self.questionLabel setText:questionData.text];
        [self.answerView setOptions: questionData.options];
        [self.answerView setAnswers: questionData.answers];
        [self.explanationLabel setText: self.questionData.explanation];
    }
    if(self.answerListener != nil) {
        [self.answerView setAnswerListener:self.answerListener];
    }
}

- (void)showChoice:(NSArray *)choice {
    self.choice = choice;
    [self.answerView showChoice:choice];
}

- (void)showAnswerWithChoice:(NSArray *)choice {
    [self showChoice:choice];
    if(self.answerView != nil) {
        [self.answerView setShouldShowAnswer:YES];
        self.answerView.answerListener = nil;
    }
    [self judgeAndShowImage];
}

- (void)hideAnswer {
    if(self.answerView != nil) {
        [self.answerView setShouldShowAnswer:NO];
        self.answerView.answerListener = self.answerListener;
    }
    self.resultImageView.hidden = YES;
    self.resultLabel.hidden = YES;
    self.resultPercentView.hidden = YES;
}

- (void)showExplanation:(BOOL)show {
    self.explanationLabel.hidden = !show;
    [self layout];
}

- (void)setAnswerListener:(id<AnswerListener>)listener {
    self->_answerListener = listener;
    if(self.answerView != nil) {
        [self.answerView setAnswerListener:listener];
    }
}

- (void)judgeAndShowImage {
    NSString* imageName = [self.questionData verifyAnswer:self.choice]?@"Vocab_Yes":@"Vocab_No";
    UIImage* image = [UIImage imageNamed:imageName];
    [self.resultImageView setImage:image];
    self.resultImageView.hidden = NO;
    
//    self.resultLabel.hidden = NO;
//    self.resultPercentView.hidden = NO;
}

@end
