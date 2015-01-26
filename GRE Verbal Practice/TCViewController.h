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
#import "PercentChartView.h"

@interface TCViewController : UIViewController<QViewController>

// UI Controls
@property(nonatomic, readwrite, retain) IBOutlet UIScrollView* scrollView;
@property(nonatomic, readwrite, retain) IBOutlet UILabel* questionLabel;
@property(nonatomic, readwrite, retain) IBOutlet TCAnswerView* answerView;
@property(nonatomic, readwrite, retain) IBOutlet UILabel* explainLabel;

@property(nonatomic, readwrite, retain) IBOutlet UIImageView* resultImageView;
@property(nonatomic, readwrite, retain) IBOutlet PercentChartView* resultPercentView;
@property(nonatomic, readwrite, retain) IBOutlet UILabel* resultLabel;

@property(nonatomic, readwrite, retain) IBOutlet NSLayoutConstraint* viewWidth;
@property(nonatomic, readwrite, retain) IBOutlet NSLayoutConstraint* questionHeight;
@property(nonatomic, readwrite, retain) IBOutlet NSLayoutConstraint* answerHeight;
@property(nonatomic, readwrite, retain) IBOutlet NSLayoutConstraint* explainHeight;

// Data Model
@property(nonatomic, readwrite, retain) TCQuestion* questionData;
@property(nonatomic, readwrite, retain) NSArray* choice;
@property(nonatomic, readwrite, retain) id<AnswerListener> answerListener;

@end
