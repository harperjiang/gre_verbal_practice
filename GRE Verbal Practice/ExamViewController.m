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
}

- (void)viewDidLayoutSubviews {
    
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
    
}

- (void)markQuestion:(id)button {
    
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
