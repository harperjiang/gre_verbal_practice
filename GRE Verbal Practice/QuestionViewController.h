//
//  QuestionViewController.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/17/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QViewController.h"
#import "Question.h"
#import "QuestionSet.h"


@interface QuestionViewController : UIViewController<AnswerListener> {
    id<QViewController> currentController;
}

@property(nonatomic, readwrite, strong) QuestionSet* questionSet;

@property(nonatomic, readwrite, strong) IBOutlet UIView* toolbarView;
@property(nonatomic, readwrite, strong) IBOutlet UIView* containerView;
@property(nonatomic, readwrite, strong) IBOutlet UIButton* toggleButton;

- (IBAction)toggleToolbar:(id)sender;

- (IBAction)showAnswer:(id)sender;
- (IBAction)nextQuestion:(id)sender;

@end
