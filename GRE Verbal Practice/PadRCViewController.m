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
    _tapSupporter = [[TextViewTapSupporter alloc] init];
    _tapSupporter.textView = self.articleTextView;
    _tapSupporter.font = [UIFont systemFontOfSize:16];

    if(self.questionData != nil) {
        [self.questionLabel setText: self.questionData.text];
        [self.answerView setOptions: self.questionData.options multiple:self.questionData.multiple];
        
        [self.explainLabel setText: self.questionData.explanation];
        [_tapSupporter setText:self.questionData.readText.text];
    }
    if(self.answerListener != nil) {
        [self.answerView setAnswerListener:self.answerListener];
    }
}

- (void)viewDidLayoutSubviews {
    [self layout];
    [super viewDidLayoutSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)layout {
    CGRect bounds = self.scrollView.frame;
    
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
    if(self.questionData.selectSentence) {
        [_tapSupporter selectSentences:choice highlight:YES];
    } else {
        [self.answerView showChoice:choice];
    }
}

- (void)showAnswerWithChoice:(NSArray *)choice {
    [self showChoice:choice];
    if(self.questionData.selectSentence) {
        [_tapSupporter markSentences:self.questionData.answers highlight:YES];
        
    } else {
        [self.answerView setShouldShowAnswer: YES];
    }
    [self judgeAndShowImage];
}

- (void)hideAnswer {
    if(self.questionData.selectSentence) {
        [_tapSupporter markSentences:self.questionData.answers highlight:NO];
    } else {
        [self.answerView setShouldShowAnswer: NO];
    }
    self.resultImageView.hidden = YES;
}

- (void)showExplanation:(BOOL)show {
    [self.explainLabel setHidden:!show];
    [self layout];
}

- (void)setAnswerListener:(id<AnswerListener>)listener {
    self->_answerListener = listener;
    if(self.answerView != nil) {
        [self.answerView setAnswerListener:listener];
    }
}

- (void) setQuestionData:(RCQuestion *)questionData {
    self->_questionData = questionData;
    if(self.questionLabel != nil) {
        [self.questionLabel setText: self.questionData.text];
        [self.answerView setOptions: self.questionData.options multiple: self.questionData.multiple];
        [self.answerView setAnswers: self.questionData.answers];
        [self.explainLabel setText: self.questionData.explanation];
        [_tapSupporter setText:self.questionData.readText.text];
    }
}

-(IBAction) onTap:(id)sender {
    UITapGestureRecognizer* tap = (UITapGestureRecognizer*)sender;
    [_tapSupporter onTap: tap];
    if(self.questionData.selectSentence) {
        NSInteger selected = [_tapSupporter selectedSentence];
        [self.answerListener answerChanged:@[[NSNumber numberWithInteger:selected]]];
    }
}

- (void)judgeAndShowImage {
    NSString* imageName = [self.questionData verifyAnswer:self.choice]?@"Vocab_Yes":@"Vocab_No";
    UIImage* image = [UIImage imageNamed:imageName];
    [self.resultImageView setImage:image];
    self.resultImageView.hidden = NO;
}

@end
