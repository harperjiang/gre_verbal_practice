//
//  QuestionViewController.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/17/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "QuestionViewController.h"
#import "QuestionListController.h"
#import "QViewController.h"
#import "MessageViewController.h"
#import "UIUtils.h"

@interface QuestionViewController ()

@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIUtils backgroundColor];
    
    // Setup Child View
    if(self->currentController != nil)
        return;
    
    NSString* vcid = @"";
    if(![self.questionSet isEmpty]) {
        switch([self.questionSet type]) {
            case TEXT_COMPLETION:
                vcid = @"TCViewController";
                break;
            case SENTENCE_EQUIV:
                vcid = @"SEViewController";
                break;
            case READING_COMP:
                vcid = @"RCViewController";
                break;
            default:
                NSLog(@"Error when loading subviews, no subview to load");
                abort();
        }
    } else {
        vcid = @"MessageViewController";
        [self.toolbarView setHidden:YES];
        [self.toggleButton setHidden:YES];
    }
    
    UIViewController* vc = (UIViewController*)[self.storyboard instantiateViewControllerWithIdentifier:vcid];
    [self showContentController: vc];

    if(self.questionSet != nil) {
        [self.questionSet reset];
        [self showQuestion: [self.questionSet question]];
    }
}

- (void)willMoveToParentViewController:(UIViewController *)parent {
    // When going back to question selection, clear out selected answers
    if (parent == nil) {
        [self.questionSet.answers removeAllObjects];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toggleToolbar:(id)sender {
    [self.toolbarView setHidden: !self.toolbarView.hidden];
    UIButton* btn = (UIButton*)sender;
    
    UIImage* leftImage = [UIImage imageNamed:@"Question_ShowBar"];
    UIImage* rightImage = [UIImage imageNamed:@"Question_HideBar"];
    if(self.toolbarView.hidden) {
        [btn setImage:leftImage  forState:UIControlStateNormal];
    } else {
        [btn setImage:rightImage  forState:UIControlStateNormal];
    }
}

- (IBAction)showAnswer:(id)sender {
    if(self->currentController != nil) {
        [self->currentController showAnswerWithChoice:[self.questionSet answerForIndex:self.questionSet.current]];
    }
    [self.showAnswerButton setHidden:YES];
    [self.explainButton setHidden:NO];
}

- (IBAction)showExplanation:(id)sender {
    if(self->currentController != nil) {
        [self->currentController showExplanation:YES];
    }
}

- (void)reset {
    // Reset the view to normal mode
    [self->currentController hideAnswer];
    [self->currentController showExplanation:NO];
    [self.showAnswerButton setHidden:NO];
    [self.explainButton setHidden:YES];
}

- (void)showQuestion:(Question*)question {
    [self reset];
    // Set Next Question to view controller
    [self->currentController setQuestionData: question];
    [self->currentController showChoice: [self.questionSet answerForIndex:self.questionSet.current]];
    // Change Navigation Title
    self.navigationItem.title = [NSString stringWithFormat:@"%zd/%zd",
                                     self.questionSet.current + 1,
                                     self.questionSet.size];
}

- (IBAction)swipe:(UISwipeGestureRecognizer*)recognizer {
    if(recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        [self nextQuestion:recognizer];
    }
    if(recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        [self prevQuestion:recognizer];
    }
}

- (IBAction)prevQuestion:(id)sender {
    if(![self.questionSet prev]) {
        UIAlertController* messageBox =
        [UIAlertController alertControllerWithTitle:@"First"
                                            message:@"Already the first question"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okAction = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       [self dismissViewControllerAnimated:YES completion:nil];
                                   }];
        
        [messageBox addAction: okAction];
        [self presentViewController:messageBox animated:YES completion:nil];
    } else {
        [self showQuestion: [self.questionSet question]];
    }
}

- (IBAction)nextQuestion:(id)sender {
    if(![self.questionSet next]) {
        UIAlertController* messageBox =
        [UIAlertController alertControllerWithTitle:@"Last"
                                            message:@"Already the last question"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okAction = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       [self dismissViewControllerAnimated:YES completion:nil];
                                   }];
        
        [messageBox addAction: okAction];
        [self presentViewController:messageBox animated:YES completion:nil];
    } else {
        [self showQuestion: [self.questionSet question]];
    }
}

- (void)hideContentController:(UIViewController*) vc {
    [vc willMoveToParentViewController:nil];  // 1
    [vc.view removeFromSuperview];            // 2
    [vc removeFromParentViewController];      // 3
    [(id<QViewController>)vc setAnswerListener: nil];
}

- (void)showContentController:(UIViewController*) vc {
    if(vc == (UIViewController*)currentController)
        return;
    if(self->currentController != nil) {
        [self hideContentController:(UIViewController*)self->currentController];
    }
    [self addChildViewController:vc];
    vc.view.frame = self.containerView.frame;
    [vc.view layoutIfNeeded];
    [self.containerView addSubview: vc.view];
    [vc didMoveToParentViewController:self];
    currentController = (id<QViewController>)vc;
    [currentController setAnswerListener: self];
}

- (void) answerChanged:(NSArray *)answer {
    [self.questionSet answer:answer];
}

- (BOOL)automaticallyAdjustsScrollViewInsets {
    return NO;
}

- (void)shouldShrink:(NSInteger)bottomdist {
    self.adBottomConstraint.constant = bottomdist;
}

@end
