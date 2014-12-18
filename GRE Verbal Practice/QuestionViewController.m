//
//  QuestionViewController.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/17/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "QuestionViewController.h"
#import "QViewController.h"

@interface QuestionViewController ()

@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if(self->currentController != nil)
        return;
    
    NSString* vcid = @"";
    if(self.questionSet != nil) {
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
                return;
        }
    } else {
        vcid = @"MessageViewController";
        [self.toolbarView setHidden:YES];
        [self.toggleButton setHidden:YES];
    }
    
    UIViewController* vc = (UIViewController*)[self.storyboard instantiateViewControllerWithIdentifier:vcid];
    [self showContentController: vc];

    if(self.questionSet != nil) {
        Question* firstQuestion = [self.questionSet nextQuestion];
        [self->currentController setQuestionData:firstQuestion];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toggleToolbar:(id)sender {
    [self.toolbarView setHidden: !self.toolbarView.hidden];
    UIButton* btn = (UIButton*)sender;
    [btn setTitle: self.toolbarView.hidden?@"Show":@"Hide" forState:UIControlStateNormal];
}

- (IBAction)showAnswer:(id)sender {
    if(self->currentController != nil) {
        [self->currentController showAnswer];
    }
}

- (IBAction)nextQuestion:(id)sender {
    // Get Next Question from Question List
    Question* question = [self.questionSet nextQuestion];
    if(question == nil) {
        // Show Result
        
    } else {
        // Set Next Question to view controller
        [self->currentController setQuestionData: question];
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
    [self.containerView addSubview: vc.view];
    [vc didMoveToParentViewController:self];
    currentController = (id<QViewController>)vc;
    [currentController setAnswerListener: self];
}

- (void) answerChanged:(NSArray *)answer {
    [self.questionSet answer:answer];
}

@end
