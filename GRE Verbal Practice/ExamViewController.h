//
//  ExamViewController.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/16/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SEViewController.h"
#import "RCViewController.h"
#import "TCViewController.h"
#import "ExamResultViewController.h"
#import "MessageViewController.h"
#import "ExamTimer.h"
#import "ExamSuite.h"
#import "AnswerListener.h"

@interface ExamViewController : UIViewController<AnswerListener> {
    SEViewController* sevc;
    id<QViewController> rcvc;
    TCViewController* tcvc;
    ExamResultViewController* ervc;
    
    MessageViewController* msgvc;
    
    id<QViewController> currentController;
    
    ExamTimer* timer;
}

@property(nonatomic, readwrite, strong) ExamSuite* examSuite;

@property(nonatomic, readwrite, strong) IBOutlet UIView* containerView;
@property(nonatomic, readwrite, strong) IBOutlet UILabel* timeLabel;
@property(nonatomic, readwrite, strong) IBOutlet UIToolbar* toolbar;

- (IBAction)nextQuestion: (id) button;
- (IBAction)prevQuestion: (id) button;
- (IBAction)markQuestion: (id) button;
- (IBAction)showResult:(id) button;

@end
