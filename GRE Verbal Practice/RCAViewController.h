//
//  RCAViewController.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/15/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LinenumView.h"

@interface RCAViewController : UIViewController

@property(nonatomic, readwrite, retain) IBOutlet UIScrollView* scrollView;
@property(nonatomic, readwrite, retain) IBOutlet UITextView* articleText;
@property(nonatomic, readwrite, retain) IBOutlet LinenumView* linenumView;
@property(nonatomic, readwrite, retain) IBOutlet NSLayoutConstraint* widthConstraint;
@property(nonatomic, readwrite, retain) IBOutlet NSLayoutConstraint* heightConstraint;

@property(nonatomic, readwrite) NSString* article;

@end
