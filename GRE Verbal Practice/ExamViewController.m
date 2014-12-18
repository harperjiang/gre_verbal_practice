//
//  ExamViewController.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/16/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "ExamViewController.h"

@interface ExamViewController ()

@end

@implementation ExamViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    sevc = (SEViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"SEViewController"];
    tcvc = (TCViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"TCViewController"];
    rcvc = (RCViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"RCViewController"];
    ervc = (ExamResultViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"ExamResultViewController"];
    msgvc = (MessageViewController*)[self.storyboard
        instantiateViewControllerWithIdentifier:@"MessageViewController"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // Check Exam Suite
    if([self.examSuite size] == 0) {
        [self showContentController:msgvc];
        [self.toolbar setHidden:YES];
    }else {
        [self showQuestion: [self.examSuite nextQuestion]];
        // Initialize Timer
        timer = [[ExamTimer alloc] initWithMinutes:[self.examSuite timeLimit] target:self interval: @selector(timerInterval:) done: @selector(showResultView)];
    }
}

- (void)showQuestion:(Question*) question {
    if(question == nil) {
        NSLog(@"Error, empty question shown");
        return;
    }
    switch([question type]) {
        case READING_COMP:
            [rcvc setQuestionData:(RCQuestion*)question];
            [self showContentController: rcvc];
            break;
        case TEXT_COMPLETION:
            [tcvc setQuestionData:(TCQuestion*)question];
            [self showContentController: tcvc];
            break;
        case SENTENCE_EQUIV:
            [sevc setQuestionData:(SEQuestion*)question];
            [self showContentController: sevc];
            break;
        default:
            break;
    }
}

- (void)timerInterval:(NSNumber*) r {
    long remain = [r longValue];
    long hour = remain / 3600;
    remain = remain % 3600;
    long minute = remain / 60;
    long second = remain % 60;
    [self.timeLabel setText:[NSString stringWithFormat:@"%02ld:%02ld:%02ld", hour, minute, second]];
}

- (void)showResultView {
    // Send Result Information to Result view
    // TODO
    // Show result view and disable toolbar
    [self showContentController:ervc];
    [self.toolbar setHidden:YES];
    [self.timeLabel setHidden:YES];
    [self->timer stop];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)hideContentController:(UIViewController*) vc {
    [vc willMoveToParentViewController:nil];  // 1
    [vc.view removeFromSuperview];            // 2
    [vc removeFromParentViewController];      // 3
    [(id<QViewController>)vc setAnswerListener: nil];
}

- (void)showContentController:(UIViewController*) vc {
    if(currentController != vc) {
        if(currentController != nil) {
            [self hideContentController: currentController];
        }
        [self addChildViewController:vc];
        vc.view.frame = self.containerView.frame;
        [self.containerView addSubview: vc.view];
        [vc didMoveToParentViewController:self];
        currentController = vc;
        [(id<QViewController>)currentController setAnswerListener: self];
    }
}

- (void)nextQuestion:(id)button {
    Question* next = [self.examSuite nextQuestion];
    if(next == nil) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"The end"
                              message:@"This is the last question!"
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    [self showQuestion: next];
}

- (void)prevQuestion:(id)button {
    Question* prev = [self.examSuite prevQuestion];
    if(prev == nil) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"No more"
                              message:@"This is the first question!"
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil, nil];
        [alert show];

        return;
    }
    [self showQuestion: prev];
}

- (void)markQuestion:(id)button {
    
}

- (void)showResult:(id)button {
    [self showResultView];
}

- (void)answerChanged:(NSArray *)answer {
    [self.examSuite answer:answer for: self.examSuite.current];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
