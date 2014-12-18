//
//  QuestionViewController.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/17/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QViewController.h"

typedef enum { SENTENCE_EQUIV, READING_COMP, TEXT_COMPLETION } QuestionType;

@interface QuestionViewController : UIViewController {
    id<QViewController> currentController;
}

@property(nonatomic, readwrite) QuestionType questionType;

@property(nonatomic, readwrite, strong) IBOutlet UIView* toolbarView;
@property(nonatomic, readwrite, strong) IBOutlet UIView* containerView;

- (IBAction)toggleToolbar:(id)sender;

- (IBAction)showAnswer:(id)sender;
- (IBAction)nextQuestion:(id)sender;

@end
