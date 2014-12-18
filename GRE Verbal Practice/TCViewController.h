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
@property(nonatomic, readwrite, retain) IBOutlet UILabel* questionLabel;
@property(nonatomic, readwrite, retain) IBOutlet TCAnswerView* answerView;

// Data Model
@property(nonatomic, readwrite, retain) TCQuestion* questionData;

@end
