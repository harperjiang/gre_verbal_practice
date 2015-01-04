//
//  QuestionViewController.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/17/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "QuestionViewController.h"
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
    
    // Setup Ad
    self.adSupport = [[AdBannerSupport alloc] init];
    // On iOS 6 ADBannerView introduces a new initializer, use it when available.
    if ([ADBannerView instancesRespondToSelector:@selector(initWithAdType:)]) {
        _bannerView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
    } else {
        _bannerView = [[ADBannerView alloc] init];
    }
    
    [self.adSupport setBannerView: _bannerView];
    [self.view addSubview:_bannerView];
    
    [self.adSupport setParentView: self.view];
    [self.adSupport setShrinkView: self.containerView];
    [self.adSupport setBottomConstraint: self.adBottomConstraint];

    
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

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.adSupport layoutAnimated:NO];
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
        [self->currentController showAnswer:YES];
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
    [self->currentController showAnswer:NO];
    [self->currentController showExplanation:NO];
    [self.showAnswerButton setHidden:NO];
    [self.explainButton setHidden:YES];
}

- (void)showQuestion:(Question*)question {
    [self reset];
    // Set Next Question to view controller
    [self->currentController setQuestionData: question];
        
    // Change Navigation Title
    self.navigationItem.title = [NSString stringWithFormat:@"%ld/%ld",
                                     self.questionSet.current + 1,
                                     self.questionSet.size];
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


@end
