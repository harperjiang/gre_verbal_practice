//
//  QuestionListController.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/29/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"

@interface QuestionListController : UITableViewController

@property(nonatomic) IBOutlet UITableView* questionTableView;

@property(nonatomic) QuestionType questionType;
@property(nonatomic) NSArray* questionSets;

@end
