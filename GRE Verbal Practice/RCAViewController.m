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
    [self.linenumView setFont: self.articleText.font];
    [self.linenumView setMargin:23];
    [self.linenumView setBorder: 10];
    [self.linenumView setLineSpacing:0.1];
    [self.articleText scrollRangeToVisible:NSMakeRange(0, 0)];
}

- (void)viewWillLayoutSubviews {
//    CGSize contentSize = self.articleText.contentSize;
    CGSize fit = [self.articleText sizeThatFits:CGSizeMake(10000, 10000)];
    self.widthConstraint.constant = fit.width;
    self.heightConstraint.constant = fit.height;
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
