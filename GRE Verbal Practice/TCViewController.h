//
//  TCViewController.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/9/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

/**
 * ViewController for Text Completion
 **/
#import <UIKit/UIKit.h>
#import "TCQuestion.h"
#import "TCAnswerView.h"
#import "QViewController.h"

@interface TCViewController : UIViewController<QViewController>

// UI Controls
@property(nonatomic, readwrite, retain) IBOutlet UIScrollView* scrollView;
@property(nonatomic, readwrite, retain) IBOutlet UILabel* questionLabel;
@property(nonatomic, readwrite, retain) IBOutlet TCAnswerView* answerView;
@property(nonatomic, readwrite, retain) IBOutlet UILabel* explainLabel;

@property(nonatomic, readwrite, retain) IBOutlet NSLayoutConstraint* viewWidth;
@property(nonatomic, readwrite, retain) IBOutlet NSLayoutConstraint* questionHeight;
@property(nonatomic, readwrite, retain) IBOutlet NSLayoutConstraint* answerHeight;
@property(nonatomic, readwrite, retain) IBOutlet NSLayoutConstraint* explainHeight;

// Data Model
@property(nonatomic, readwrite, retain) TCQuestion* questionData;

@end
