//
//  QuizResultController.h
//  GRE Verbal Master
//
//  Created by Harper on 1/31/15.
//  Copyright (c) 2015 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "TitleView.h"
#import "VocabQuizSet.h"

@interface QuizResultController : UIViewController {
    UIView* _maskView;
    
    AVAudioPlayer* _givestarPlayer;
}

@property(nonatomic) IBOutlet TitleView* scoreView;
@property(nonatomic) IBOutlet TitleView* pbestView;
@property(nonatomic) IBOutlet TitleView* wordrightView;
@property(nonatomic) IBOutlet TitleView* rankView;

@property(nonatomic) VocabQuizSet* quizSet;


- (IBAction)reviewQuiz:(id)sender;
- (IBAction)newQuiz:(id)sender;

@end
