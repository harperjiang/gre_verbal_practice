//
//  ExamResultViewController.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/17/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QViewController.h"

@interface ExamResultViewController : UIViewController<QViewController>

@property(nonatomic, readwrite, strong) IBOutlet UILabel* timeLabel;
@property(nonatomic, readwrite, strong) IBOutlet UILabel* resultLabel;

@end
