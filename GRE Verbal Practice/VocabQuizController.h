//
//  VocabQuizController.h
//  GRE Verbal Master
//
//  Created by Harper on 1/28/15.
//  Copyright (c) 2015 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "TitleView.h"
#import "ExamTimer.h"
#import "VocabQuizSet.h"

@interface VocabQuizController : UIViewController {
    ExamTimer* _timer;
    
    AVAudioPlayer* _tickPlayer;
    AVAudioPlayer* _countPlayer;
    AVAudioPlayer* _correctPlayer;
    AVAudioPlayer* _incorrectPlayer;
    
    UIView* _maskView;
}

@property(atomic) BOOL stopped;

@property(nonatomic) IBOutlet TitleView* questionTitle;
@property(nonatomic) IBOutlet TitleView* timeTitle;
@property(nonatomic) IBOutlet TitleView* scoreTitle;

@property(nonatomic) IBOutlet UILabel* questionLabel;
@property(nonatomic) IBOutlet UIButton* answer1Button;
@property(nonatomic) IBOutlet UIButton* answer2Button;
@property(nonatomic) IBOutlet UIButton* answer3Button;
@property(nonatomic) IBOutlet UIButton* answer4Button;

@property(nonatomic) IBOutlet NSLayoutConstraint* buttonLeftOffset;
@property(nonatomic) IBOutlet NSLayoutConstraint* buttonRightOffset;

@property(nonatomic) VocabQuizSet* quizSet;

- (IBAction)onAnswer:(id)sender;

- (IBAction)showReview:(id)sender;

@end
