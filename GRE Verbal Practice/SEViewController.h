//
//  SEViewController.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/15/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SEAnswerView.h"
#import "SEQuestion.h"
#import "QViewController.h"
#import "PercentChartView.h"

@interface SEViewController : UIViewController<QViewController>

@property(nonatomic, readwrite, retain) IBOutlet UIScrollView* scrollView;
@property(nonatomic, readwrite, retain) IBOutlet UILabel* questionLabel;
@property(nonatomic, readwrite, retain) IBOutlet SEAnswerView* answerView;
@property(nonatomic, readwrite, retain) IBOutlet UILabel* explanationLabel;

@property(nonatomic, readwrite, retain) IBOutlet UIImageView* resultImageView;
@property(nonatomic, readwrite, retain) IBOutlet PercentChartView* resultPercentView;
@property(nonatomic, readwrite, retain) IBOutlet UILabel* resultLabel;

@property(nonatomic, readwrite, retain) IBOutlet NSLayoutConstraint* viewWidth;
@property(nonatomic, readwrite, retain) IBOutlet NSLayoutConstraint* titleHeight;
@property(nonatomic, readwrite, retain) IBOutlet NSLayoutConstraint* answerHeight;
@property(nonatomic, readwrite, retain) IBOutlet NSLayoutConstraint* explainHeight;

@property(nonatomic, readwrite, retain) SEQuestion* questionData;
@property(nonatomic, readwrite, retain) NSArray* choice;
@property(nonatomic, readwrite, retain) id<AnswerListener> answerListener;

@end
