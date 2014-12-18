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
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // Initialize Timer
    timer = [[ExamTimer alloc] initWithMinutes:30 target:self interval: @selector(timerInterval:) done: @selector(showResultView)];

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
    [self switchController:ervc];
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
}

- (void)showContentController:(UIViewController*) vc {
    [self addChildViewController:vc];
    vc.view.frame = self.containerView.frame;
    [self.containerView addSubview: vc.view];
    [vc didMoveToParentViewController:self];
    currentVC = vc;
}

- (void)switchController:(UIViewController*) vc {
    if(currentVC != nil) {
        [self hideContentController: currentVC];
    }
    [self showContentController:vc];
    currentVC = vc;
}

- (void)nextQuestion:(id)button {
    if(currentVC == nil) {
        [self switchController: sevc];
    } else if(currentVC == sevc) {
        [self switchController: tcvc];
    } else if(currentVC == tcvc) {
        [self switchController: rcvc];
    } else if(currentVC == rcvc) {
        [self switchController: sevc];
    }
}

- (void)prevQuestion:(id)button {
    if(currentVC == nil) {
        [self switchController: rcvc];
    } else if(currentVC == rcvc) {
        [self switchController: tcvc];
    } else if(currentVC == tcvc) {
        [self switchController: sevc];
    } else if(currentVC == sevc) {
        [self switchController: rcvc];
    }
}

- (void)markQuestion:(id)button {
    
}

- (void)showResult:(id)button {
    [self showResultView];
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
