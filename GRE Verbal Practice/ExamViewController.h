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
#import "ExamResultController.h"
#import "MessageViewController.h"
#import "ExamTimer.h"
#import "ExamSuite.h"
#import "AnswerListener.h"
#import "MenuView.h"
#import "AdBannerSupport.h"

@interface ExamViewController : UIViewController<AnswerListener, UITableViewDelegate, UITableViewDataSource, AdBannerTarget> {
    
    SEViewController* sevc;
    id<QViewController> rcvc;
    TCViewController* tcvc;
    MessageViewController* msgvc;
    
    id<QViewController> currentController;
    
    ExamTimer* timer;
    
    MenuView* menuView;
    NSMutableSet* markedQuestions;
    UIBarButtonItem* timeButton;
}

@property(nonatomic, readwrite, strong) ExamSuite* examSuite;
@property(nonatomic, readwrite, strong) UILabel* timeLabel;
@property(nonatomic, readwrite) BOOL reviewMode;

@property(nonatomic, readwrite, strong) IBOutlet NSLayoutConstraint* adBottomConstraint;

@property(nonatomic, readwrite, strong) IBOutlet UIView* containerView;
@property(nonatomic, readwrite, strong) IBOutlet UIButton* prevButton;
@property(nonatomic, readwrite, strong) IBOutlet UIButton* nextButton;

- (void)markQuestion: (id) button;
- (void)showResult:(id) button;

- (IBAction)prevQuestion:(id)button;
- (IBAction)nextQuestion:(id)button;
- (IBAction)swipe:(UISwipeGestureRecognizer *)recognizer;

- (void)showMenu:(id)sender event:(UIEvent*)event;
- (void)toggleTime:(id)sender event:(UIEvent*)event;
@end
