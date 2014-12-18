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
#import "ExamTimer.h"

@interface ExamViewController : UIViewController {
    SEViewController* sevc;
    RCViewController* rcvc;
    TCViewController* tcvc;
    ExamResultViewController* ervc;
    
    UIViewController* currentVC;
    
    ExamTimer* timer;
}

@property(nonatomic, readwrite, strong) IBOutlet UIView* containerView;
@property(nonatomic, readwrite, strong) IBOutlet UILabel* timeLabel;
@property(nonatomic, readwrite, strong) IBOutlet UIToolbar* toolbar;

- (IBAction)nextQuestion: (id) button;
- (IBAction)prevQuestion: (id) button;
- (IBAction)markQuestion: (id) button;
- (IBAction)showResult:(id) button;

@end
