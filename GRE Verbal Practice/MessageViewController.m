//
//  MessageViewController.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/17/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "MessageViewController.h"

@implementation MessageViewController

- (void)viewDidAppear:(BOOL)animated {
    if(self.message != nil) {
        [self.messageLabel setText:self.message];
    }
}

- (void)setQuestionData:(Question *)data {
    
}

- (Question*)questionData {
    return nil;
}

- (void)showAnswer {
    
}

- (void)showExplanation {
    
}

- (void)showChoice:(NSArray *)choice {
    
}

- (void)setAnswerListener:(id<AnswerListener>)listener {
    
}

@end
