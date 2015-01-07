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
#import "TextViewTapSupporter.h"

@interface PadRCViewController : UIViewController<QViewController>{
    TextViewTapSupporter* _tapSupporter;
}


@property(nonatomic, readwrite, strong) IBOutlet UITextView* articleTextView;
@property(nonatomic, readwrite, retain) IBOutlet UILabel* questionLabel;
@property(nonatomic, readwrite, retain) IBOutlet RCAnswerView* answerView;
@property(nonatomic, readwrite, retain) IBOutlet UIScrollView* scrollView;
@property(nonatomic, readwrite, retain) IBOutlet UILabel* explainLabel;
@property(nonatomic, readwrite, retain) IBOutlet UIImageView* resultImageView;

@property(nonatomic, readwrite, retain) IBOutlet NSLayoutConstraint* viewWidth;
@property(nonatomic, readwrite, retain) IBOutlet NSLayoutConstraint* questionHeight;
@property(nonatomic, readwrite, retain) IBOutlet NSLayoutConstraint* answerHeight;
@property(nonatomic, readwrite, retain) IBOutlet NSLayoutConstraint* explainHeight;

// Data Model
@property(nonatomic, readwrite, retain) id<AnswerListener> answerListener;
@property(nonatomic, readwrite, retain) NSArray* choice;
@property(nonatomic, readwrite, strong) RCQuestion* questionData;

- (IBAction)onTap:(id)sender;

@end
