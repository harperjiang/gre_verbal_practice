//
//  RCAViewController.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/15/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LinenumView.h"
#import "TextViewTapSupporter.h"
#import "RCQuestion.h"
#import "AnswerListener.h"
#import "QViewController.h"

@interface RCAViewController : UIViewController<QViewController> {
    TextViewTapSupporter* _tapSupporter;
}

@property(nonatomic, readwrite, retain) IBOutlet UITextView* articleTextView;

@property(nonatomic, readwrite) BOOL shouldShowAnswer;
@property(nonatomic, readwrite) NSArray* choice;
@property(nonatomic, readwrite) id<AnswerListener> answerListener;
@property(nonatomic, readwrite, retain) RCQuestion* questionData;

-(IBAction) onArticleTapped:(id)sender;

@end
