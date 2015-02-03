//
//  QuizReviewController.m
//  GRE Verbal Master
//
//  Created by Harper on 1/31/15.
//  Copyright (c) 2015 Hao Jiang. All rights reserved.
//

#import "QuizReviewController.h"
#import "UIUtils.h"
#import "ExtendView.h"

@interface QuizReviewController ()

@end

@implementation QuizReviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIUtils backgroundColor];
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
//    [dict setObject:self.starterView forKey:@"starterView"];
//    for(VocabQuiz* quiz in self.quizSet.questions) {
    ExtendView* eview1 = [[ExtendView alloc] initWithFrame:CGRectMake(0,0,0,0)];
    eview1.mainLabel.text = @"Question 1";
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [label setText:@"This is the hidden label"];
    eview1.extendView = label;
    
    ExtendView* eview2 = [[ExtendView alloc] initWithFrame:CGRectMake(0,0,0,0)];
    eview2.mainLabel.text = @"Question 2";
    
     //NSString* eviewid = [NSString stringWithFormat:@"eview%zd",count];
    [dict setObject:eview1 forKey:@"eview1"];
    [dict setObject:eview2 forKey:@"eview2"];
    [self.containerView addSubview:eview1];
    [self.containerView addSubview:eview2];
    // Add Constraint
    NSString* format = @"|-0-[eview1]-0-|";
    NSArray* hContainer = [NSLayoutConstraint constraintsWithVisualFormat:format
                                                                  options:0
                                                                  metrics:nil
                                                                    views:dict];
    [self.containerView addConstraints:hContainer];
    format = @"|-0-[eview2]-0-|";
    hContainer = [NSLayoutConstraint constraintsWithVisualFormat:format
                                                         options:0
                                                         metrics:nil
                                                           views:dict];
    [self.containerView addConstraints:hContainer];
 
    // Add V constraint to starterView
    NSString* vlan = @"V:|-[eview1]-[eview2]-|";
    NSArray* etos = [NSLayoutConstraint constraintsWithVisualFormat: vlan
                                                                options: 0
                                                                metrics: nil
                                                                  views: dict];
    [self.containerView addConstraints:etos];
    
//        count += 1;
//    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    // Set Width Constraint
    self.containerWidth.constant = self.view.bounds.size.width;
}

@end
