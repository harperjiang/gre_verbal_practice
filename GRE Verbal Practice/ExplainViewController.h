//
//  ExplainViewController.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/21/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExplainViewController : UIViewController

@property(nonatomic, readwrite, strong) IBOutlet UITextView* explainText;
@property(nonatomic, readwrite, strong) NSString* explainContent;


@end
