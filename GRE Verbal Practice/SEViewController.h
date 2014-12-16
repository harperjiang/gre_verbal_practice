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

@interface SEViewController : UIViewController

@property(nonatomic, readwrite, retain) IBOutlet UILabel* questionLabel;
@property(nonatomic, readwrite, retain) IBOutlet SEAnswerView* answerView;

@property(nonatomic, readwrite, retain) SEQuestion* questionData;

@end
