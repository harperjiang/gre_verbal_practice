//
//  QuizResultController.m
//  GRE Verbal Master
//
//  Created by Harper on 1/31/15.
//  Copyright (c) 2015 Hao Jiang. All rights reserved.
//

#import "QuizResultController.h"
#import "UserPreference.h"
#import "QuizReviewController.h"
#import "UIUtils.h"

@interface QuizResultController ()

@end

@implementation QuizResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIUtils backgroundColor];
    
    _maskView = [[UIView alloc] initWithFrame:CGRectMake(0,0,10,10)];
    [_maskView setAlpha:0.1];
    
    _givestarPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: [[NSBundle mainBundle] URLForResource:@"givestar" withExtension:@"wav"] error:nil];
    
    self.scoreView.titleLabel.text = @"SCORE";
    self.scoreView.scoreLabel.textColor = [UIUtils chromeRed];
    self.scoreView.scoreLabel.font = [UIFont boldSystemFontOfSize:40] ;
    self.pbestView.titleLabel.text = @"PERSONAL BEST";
    self.pbestView.scoreLabel.textColor = [UIUtils darkBlue];
    self.pbestView.scoreLabel.font = [UIFont boldSystemFontOfSize:16];
    self.wordrightView.titleLabel.text = @"WORDS YOU GOT RIGHT";
    self.wordrightView.scoreLabel.textColor = [UIUtils darkBlue];
    self.wordrightView.scoreLabel.font = [UIFont boldSystemFontOfSize:20];
    self.rankView.titleLabel.text = @"RANK";
    self.rankView.scoreLabel.textColor = [UIUtils darkBlue];
    self.rankView.scoreLabel.font = [UIFont boldSystemFontOfSize:16];
    
    
    NSInteger highscore = [UserPreference getInteger:DATA_QUIZ_HIGHSCORE defval:0];
    if (self.quizSet.score > highscore) {
        highscore = self.quizSet.score;
        [UserPreference setInteger:highscore forKey:DATA_QUIZ_HIGHSCORE];
    }
    self.scoreView.scoreLabel.text = [NSString stringWithFormat:@"%zd", self.quizSet.score];
    self.pbestView.scoreLabel.text = [NSString stringWithFormat:@"%zd", highscore];
    self.wordrightView.scoreLabel.text = [NSString stringWithFormat: @"%zd of %zd", self.quizSet.correct,self.quizSet.size];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    
    self.rankView.scoreLabel.text = @"";
    
    [self showMask:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // Show Animation
    NSInteger rank = 4;
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for(int i = 0 ; i < rank ; i++) {
            [_givestarPlayer play];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.rankView.scoreLabel.text = [@"" stringByPaddingToLength:i+1 withString:@"\u2605" startingAtIndex:0];
            });
            [NSThread sleepForTimeInterval:1];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showMask:NO];
        });
    });
}

- (void)reviewQuiz:(id)sender {
    QuizReviewController* qrc = [self.storyboard instantiateViewControllerWithIdentifier:@"QuizReviewController"];
    qrc.quizSet = self.quizSet;
    [UIUtils popAndPush:self.navigationController push:qrc animate:NO];
}

- (void)newQuiz:(id)sender {
    UIViewController* quizController = [self.storyboard instantiateViewControllerWithIdentifier:@"VocabQuizController"];
    [UIUtils popAndPush:self.navigationController push: quizController animate:NO];
}

- (void) showMask:(BOOL)show {
    if(show) {
        _maskView.frame = self.view.bounds;
        [self.view addSubview:_maskView];
    } else {
        [_maskView removeFromSuperview];
    }
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
