//
//  VocabQuizInfoController.h
//  GRE Verbal Master
//
//  Created by Harper on 1/28/15.
//  Copyright (c) 2015 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuizInfoController : UIViewController

@property(nonatomic, strong) void (^onDismiss)(UIViewController *sender, NSObject *param);

- (IBAction)buttonPressed:(id)sender;

@end
