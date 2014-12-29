//
//  ExamPrepViewController.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/27/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExamPrepController : UIViewController<UITableViewDataSource, UITableViewDelegate>

// Data Model
@property(nonatomic, retain) NSArray* examSuites;


@property(nonatomic, retain) IBOutlet UITableView* examTableView;

@end
