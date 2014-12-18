//
//  RCViewController.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/15/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCQuestion.h"
#import "QViewController.h"

@interface RCViewController : UITabBarController<QViewController>

@property(nonatomic, readwrite, retain) RCQuestion* questionData;
@property(nonatomic, readwrite, strong) id<AnswerListener> answerListener;

@end
