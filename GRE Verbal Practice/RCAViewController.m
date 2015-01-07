//
//  RCAViewController.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/15/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "RCAViewController.h"
#import "RCViewController.h"

@interface RCAViewController ()

@end

@implementation RCAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    
    _tapSupporter = [[TextViewTapSupporter alloc] init];
    _tapSupporter.textView = self.articleTextView;
    _tapSupporter.font = [UIFont systemFontOfSize:16];
    self.articleTextView.delegate = _tapSupporter;
    
    if(self.questionData != nil) {
        [_tapSupporter setText: self.questionData.readText.text];
        if(self.questionData.selectSentence) {
            [_tapSupporter markSentences:self.questionData.answers highlight:self.shouldShowAnswer];
        }
    }
    [_tapSupporter selectSentences:self.choice highlight:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setArticle:(NSString *)article {
    [_tapSupporter setText:article];
}

- (void)onArticleTapped:(id)sender {
    [_tapSupporter onTap:(UITapGestureRecognizer*)sender];
    if(self.questionData.selectSentence) {
        [self.answerListener answerChanged:@[[NSNumber numberWithInteger:[_tapSupporter selectedSentence]]]];
    }
}

- (void)setQuestionData:(RCQuestion*) data {
    self->_questionData = data;
    if(_tapSupporter != nil) {
        [_tapSupporter setText:data.readText.text];
    }
}

- (void)showAnswerWithChoice: (NSArray*) choice {
    [self showChoice:choice];
    self.shouldShowAnswer = YES;
    [_tapSupporter markSentences:self.questionData.answers highlight:YES];
}

- (void)hideAnswer {
    self.shouldShowAnswer = NO;
    [_tapSupporter markSentences:self.questionData.answers highlight:NO];
}

- (void)showChoice:(NSArray*)choice {
    self.choice = choice;
    [_tapSupporter selectSentences:choice highlight:YES];
}

- (void)showExplanation:(BOOL)show {
    // Do nothing
}

- (void)setAnswerListener:(id<AnswerListener>)listener {
    self->_answerListener = listener;
}


@end
