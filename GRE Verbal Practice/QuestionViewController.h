//
//  QuestionViewController.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/17/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "QViewController.h"
#import "Question.h"
#import "QuestionSet.h"
#import "AdBannerSupport.h"


@interface QuestionViewController : UIViewController<AnswerListener> {
    id<QViewController> currentController;
    ADBannerView* _bannerView;
}

@property(nonatomic, readwrite, strong) QuestionSet* questionSet;

@property(nonatomic, readwrite) AdBannerSupport* adSupport;
@property(nonatomic) IBOutlet NSLayoutConstraint* adBottomConstraint;

@property(nonatomic) IBOutlet UIView* toolbarView;
@property(nonatomic) IBOutlet UIView* containerView;
@property(nonatomic) IBOutlet UIButton* toggleButton;

@property(nonatomic) IBOutlet UIButton* prevButton;
@property(nonatomic) IBOutlet UIButton* nextButton;
@property(nonatomic) IBOutlet UIButton* showAnswerButton;
@property(nonatomic) IBOutlet UIButton* explainButton;


- (IBAction)toggleToolbar:(id)sender;

- (IBAction)showAnswer:(id)sender;
- (IBAction)showExplanation:(id)sender;
- (IBAction)prevQuestion:(id)sender;
- (IBAction)nextQuestion:(id)sender;

@end
