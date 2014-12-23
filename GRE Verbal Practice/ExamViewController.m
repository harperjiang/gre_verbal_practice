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
    
    
    // Check Exam Suite
    if([self.examSuite size] == 0) {
        [self showContentController:msgvc];
        [self.toolbar setHidden:YES];
        [self.timeLabel setHidden:YES];
    }else {
        [self showQuestion: [self.examSuite question]];
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
            [self showContentController: (UIViewController*)rcvc];
            break;
        case TEXT_COMPLETION:
            [self showContentController: tcvc];
            break;
        case SENTENCE_EQUIV:
            [self showContentController: sevc];
            break;
        default:
            break;
    }
    [self->currentController setQuestionData:question];
}

- (void)timerInterval:(NSNumber*) r {
    long remain = [r longValue];
    long hour = remain / 3600;
    remain = remain % 3600;
    long minute = remain / 60;
    long second = remain % 60;
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.timeLabel setText:[NSString stringWithFormat:@"%02ld:%02ld:%02ld", hour, minute, second]];
    }];
}

- (void)showResultView {
    // Send Result Information to Result view
    // TODO
    // Show result view and disable toolbar
    void (^updateUI)() = ^void(){
        [self showContentController:ervc];
        [self.toolbar setHidden:YES];
        [self.timeLabel setHidden:YES];
    };

    if([NSThread isMainThread]) {
        updateUI();
    } else {
        [[NSOperationQueue mainQueue] addOperationWithBlock: updateUI];
    }
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
    if(currentController != (id<QViewController>)vc) {
        if(currentController != nil) {
            [self hideContentController: (UIViewController*)currentController];
        }
        [self addChildViewController:vc];
        vc.view.frame = self.containerView.frame;
        [self.containerView addSubview: vc.view];
        [vc didMoveToParentViewController:self];
        currentController = (id<QViewController>)vc;
        [(id<QViewController>)currentController setAnswerListener: self];
    }
}

- (void)nextQuestion:(id)button {
    if(![self.examSuite next]) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"The end"
                              message:@"This is the last question!"
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    [self showQuestion: [self.examSuite question]];
}

- (void)prevQuestion:(id)button {
    if(![self.examSuite prev]) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"No more"
                              message:@"This is the first question!"
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil, nil];
        [alert show];

        return;
    }
    [self showQuestion: [self.examSuite question]];
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

- (BOOL)automaticallyAdjustsScrollViewInsets {
    return NO;
}

@end
