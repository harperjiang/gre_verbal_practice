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

@property(nonatomic, readwrite, retain) IBOutlet UILabel* questionLabel;
@property(nonatomic, readwrite, retain) IBOutlet RCAnswerView* answerView;

@property(nonatomic, readwrite, retain) RCQuestion* questionData;

- (void)showAnswers:(NSArray*) answers;

@end
