//
//  RCAViewController.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/15/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "RCAViewController.h"
#import "RCViewController.h"

@interface RCAViewController ()

@end

@implementation RCAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self.articleText setText: self.article];
    [self.articleText scrollRangeToVisible:NSMakeRange(0, 0)];
}

- (void)viewDidLayoutSubviews {
//    [self setAutomaticallyAdjustsScrollViewInsets:FALSE];
////    ;
//    [self.articleText setContentOffset:CGPointMake(0,-200) animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setArticle:(NSString *)article {
    self->_article = article;
    if(self.articleText != nil) {
        [self.articleText setText: article];
        [self.articleText scrollRangeToVisible:NSMakeRange(0, 0)];
    }
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
