//
//  ExplainViewController.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/21/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "ExplainViewController.h"

@interface ExplainViewController ()

@end

@implementation ExplainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.explainText setText:self.explainContent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
