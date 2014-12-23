//
//  PadRCViewController.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/22/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCQuestion.h"
#import "AnswerListener.h"
#import "RCAnswerView.h"
#import "QViewController.h"

@interface PadRCViewController : UIViewController<QViewController>

@property(nonatomic, readwrite, strong) IBOutlet UITextView* articleTextView;
@property(nonatomic, readwrite, retain) IBOutlet UILabel* questionLabel;
@property(nonatomic, readwrite, retain) IBOutlet RCAnswerView* answerView;

@property(nonatomic, readwrite, strong) RCQuestion* questionData;

@end
