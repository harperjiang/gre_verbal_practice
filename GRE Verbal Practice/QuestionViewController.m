//
//  QuestionViewController.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/17/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "QuestionViewController.h"
#import "QViewController.h"
#import "ExplainViewController.h"
#import "MessageViewController.h"

@interface QuestionViewController ()

@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.adSupport layoutAnimated:YES];
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
        [self->currentController showAnswer];
    }
    [self.showAnswerButton setHidden:YES];
    [self.explainButton setHidden:NO];
}

- (IBAction)nextQuestion:(id)sender {
    // Get Next Question from Question List
    Question* question = [self.questionSet nextQuestion];
    if(question == nil) {
        // Show Message
        // TODO Show Question Result
        MessageViewController* vc = (MessageViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"MessageViewController"];
        [vc setMessage:@"End of QuestionSet!"];
        [self showContentController: vc];
        [self.toolbarView setHidden:YES];
        [self.toggleButton setHidden:YES];
    } else {
        // Set Next Question to view controller
        [self->currentController setQuestionData: question];
        [self.showAnswerButton setHidden:NO];
        [self.explainButton setHidden:YES];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([[segue destinationViewController] isKindOfClass:[ExplainViewController class]]) {
        ExplainViewController* evc = (ExplainViewController*)segue.destinationViewController;
        Question* currentQ = [self->currentController questionData];
        [evc setExplainContent: currentQ.explanation];
    }
}

- (BOOL)automaticallyAdjustsScrollViewInsets {
    return NO;
}


@end
