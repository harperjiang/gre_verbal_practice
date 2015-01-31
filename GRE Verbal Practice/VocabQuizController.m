//
//  VocabQuizController.m
//  GRE Verbal Master
//
//  Created by Harper on 1/28/15.
//  Copyright (c) 2015 Hao Jiang. All rights reserved.
//

#import "VocabQuizController.h"
#import "QuizResultController.h"
#import "QuizInfoController.h"
#import "InfoPresentationController.h"
#import "UIUtils.h"
#import "InfoDialogDelegate.h"

@interface VocabQuizController ()

@end

@implementation VocabQuizController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIUtils backgroundColor];
    // Init Data
    self.quizSet = [VocabQuizSet create];
    // Init UI
    UIFont* digitalFont = [UIFont fontWithName:@"Let's go Digital" size:40];
    [self.questionTitle.titleLabel setText:@"QUESTION"];
    [self.questionTitle.scoreLabel setFont:digitalFont];
    [self.timeTitle.titleLabel setText:@"TIME"];
    [self.timeTitle.scoreLabel setText:@":10"];
    [self.timeTitle.scoreLabel setFont:digitalFont];
    [self.scoreTitle.titleLabel setText:@"SCORE"];
    [self.scoreTitle.scoreLabel setFont:digitalFont];
    [self.scoreTitle.scoreLabel setText:[NSString stringWithFormat:@"%03zd", 0]];
    
    _tickPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: [[NSBundle mainBundle] URLForResource:@"tick" withExtension:@"wav"] error:nil];
    _countPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: [[NSBundle mainBundle] URLForResource:@"count" withExtension:@"wav"] error:nil];
    _correctPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: [[NSBundle mainBundle] URLForResource:@"correct" withExtension:@"aiff"] error:nil];
    _incorrectPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: [[NSBundle mainBundle] URLForResource:@"incorrect" withExtension:@"aiff"] error:nil];
    
    _maskView = [[UIView alloc] initWithFrame:CGRectMake(0,0,10,10)];
    [_maskView setAlpha:0.1];
 
    for(int i = 0 ; i < 4; i++) {
        UIButton* btn = (UIButton*)[self.view viewWithTag:i+1];
        
        btn.backgroundColor = [UIUtils backgroundColor];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        // Add Shadow
        btn.layer.shadowColor = [UIColor darkGrayColor].CGColor;
        btn.layer.shadowOpacity = 0.8;
        btn.layer.shadowRadius = 2;
        btn.layer.shadowOffset = CGSizeMake(0, 2);
    }
    _stopped = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // Prepare the first question
    [self showQuestion];
    
    // Display info dialog
    QuizInfoController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"QuizInfoController"];
    vc.transitioningDelegate = [InfoDialogDelegate instance];
    vc.onDismiss = ^(UIViewController* source, NSObject* param) {
        [self onInfoDismiss];
    };
    vc.modalPresentationStyle = UIModalPresentationCustom;
    [self.navigationController presentViewController:vc animated:NO completion: nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    self.stopped = YES;
    [_timer stop];
}

#pragma Operation Flows

- (void)startTimer {
    _timer = [[ExamTimer alloc] initWithSeconds:11 target:self interval:@selector(counterInterval:) done:@selector(counterDone)];
}

- (void)onInfoDismiss {
    // Start the timer
    [self startTimer];
}

- (void)showQuestion {
    // Reset Button Color
    [self hideAnswer];
    // Display Question Number
    self.questionTitle.scoreLabel.text = [NSString stringWithFormat:@"%zd/%zd", self.quizSet.index + 1, self.quizSet.size];
    // Display Question
    VocabQuiz* question = [self.quizSet current];
    self.questionLabel.text = question.question;
    for(int i = 0 ; i < 4 ; i++) {
        UIButton* btn = (UIButton*)[self.view viewWithTag:i+1];
        [btn setTitle:[question.options objectAtIndex:i] forState:UIControlStateNormal];
    }
    
    // Reset Color and text
    self.timeTitle.scoreLabel.textColor = [UIColor darkGrayColor];
    self.timeTitle.scoreLabel.text = [NSString stringWithFormat:@":%02zd",10];
    
    [self.view layoutIfNeeded];
}

- (void)showQuestionWithAnimation {
    [self showQuestion];
    
    self.buttonLeftOffset.constant = 40;
    self.buttonRightOffset.constant = 40;
    [UIView animateWithDuration:1 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        if(!self.stopped) {
            // Start Timer
            [self startTimer];
            [self showMask:NO];
        }
    }];
}

- (void)nextQuestion {
    if (self.stopped) {
        return;
    }
    if ([self.quizSet next]) {
        self.buttonLeftOffset.constant -= self.view.bounds.size.width;
        self.buttonRightOffset.constant += self.view.bounds.size.width;
        [UIView animateWithDuration:1 animations:^{
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            CGFloat newx = self.buttonRightOffset.constant;
            self.buttonRightOffset.constant = self.buttonLeftOffset.constant;
            self.buttonLeftOffset.constant = newx;
            [self.view layoutIfNeeded];
            [self showQuestionWithAnimation];
        }];
    } else {
        // Show result
        [self showReview:nil];
    }
}

- (void)showReview:(id)sender {
    QuizResultController* qrc = [self.storyboard instantiateViewControllerWithIdentifier:@"QuizResultController"];
    qrc.quizSet = self.quizSet;
    UINavigationController* navController = self.navigationController;
    [UIUtils popAndPush:navController push:qrc animate:NO];
}

- (void)hideAnswer {
    UIButton* rightBtn = (UIButton*)[self.view viewWithTag: self.quizSet.current.answer];
    
    rightBtn.backgroundColor = [UIUtils backgroundColor];
    rightBtn.alpha = 1;
    rightBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [rightBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    rightBtn.layer.shadowColor = [UIColor darkGrayColor].CGColor;

}

- (void)showAnswer {
    // Show correct answer
    UIButton* rightBtn = (UIButton*)[self.view viewWithTag: self.quizSet.current.answer];
    UIColor* dark = [UIUtils darkGreen];
    UIColor* light = [UIUtils lightGreen];
    
    rightBtn.backgroundColor = light;
    rightBtn.layer.borderColor = dark.CGColor;
    [rightBtn setTitleColor:dark forState:UIControlStateNormal];
    rightBtn.layer.shadowColor = dark.CGColor;
}

- (void)onAnswer:(id)sender {
    [_timer stop];
    [self showMask:YES];
    [self showAnswer];
    NSInteger _score = self.quizSet.score;
    NSInteger score = [self.quizSet answer:[(UIButton*)sender tag]];
    if (score == 0) {
        // Wrong Answer
        
        [_incorrectPlayer play];
        
        // Go to next question after 1 secs
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 1), dispatch_get_main_queue(), ^{
            [self nextQuestion];
        });
    } else {
        // Correct Answer
        [_correctPlayer play];
        // Display earned score
        self.scoreTitle.scoreLabel.backgroundColor = [UIUtils chromeGreen];
        self.scoreTitle.scoreLabel.textColor = [UIColor whiteColor];
        self.scoreTitle.scoreLabel.text = [NSString stringWithFormat:@"%03zd", score];
        
        void (^block)(void) = ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                self.scoreTitle.scoreLabel.backgroundColor = [UIColor clearColor];
                self.scoreTitle.scoreLabel.textColor = [UIColor darkGrayColor];
                [_countPlayer play];
            });
            
            // Change score in 100 steps
            NSInteger step = score / 100;
            
            for(int i = 0 ; i < 100 ; i++) {
                [NSThread sleepForTimeInterval:0.01];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.scoreTitle.scoreLabel setText:[NSString stringWithFormat:@"%03zd",_score + i * step]];
                });
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.scoreTitle.scoreLabel setText:[NSString stringWithFormat:@"%03zd",self.quizSet.score]];
            });
            // Go to next question after 1 secs
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [self nextQuestion];
            });
        };
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
    }
}

- (void) showMask:(BOOL)show {
    if(show) {
        _maskView.frame = self.view.bounds;
        [self.view addSubview:_maskView];
    } else {
        [_maskView removeFromSuperview];
    }
}

#pragma Timer Callback

- (void)counterInterval:(NSNumber*)remain {
    [self.timeTitle.scoreLabel setText:[NSString stringWithFormat:@":%02zd", remain.integerValue]];
    if(remain.integerValue <= 5) {
        [_tickPlayer play];
        self.timeTitle.scoreLabel.textColor = [UIColor redColor];
    }
}

- (void)counterDone {
    [_incorrectPlayer play];
    [self showAnswer];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{[self nextQuestion];});
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
