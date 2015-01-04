//
//  RCViewController.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/15/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCAnswerView.h"
#import "RCQuestion.h"

@interface RCQViewController : UIViewController

@property(nonatomic, readwrite, retain) IBOutlet UILabel* explainLabel;
@property(nonatomic, readwrite, retain) IBOutlet UILabel* questionLabel;
@property(nonatomic, readwrite, retain) IBOutlet RCAnswerView* answerView;

@property(nonatomic, readwrite, retain) IBOutlet NSLayoutConstraint* viewWidth;
@property(nonatomic, readwrite, retain) IBOutlet NSLayoutConstraint* questionHeight;
@property(nonatomic, readwrite, retain) IBOutlet NSLayoutConstraint* answerHeight;
@property(nonatomic, readwrite, retain) IBOutlet NSLayoutConstraint* explainHeight;

@property(nonatomic, readwrite) BOOL shouldShowAnswer;
@property(nonatomic, readwrite) BOOL shouldShowExplanation;
@property(nonatomic, readwrite) NSArray* choice;
@property(nonatomic, readwrite) id<AnswerListener> answerListener;
@property(nonatomic, readwrite, retain) RCQuestion* questionData;

- (void)showAnswer:(BOOL)show;
- (void)showExplanation:(BOOL)show;
- (void)showChoice:(NSArray*)choice;

@end
