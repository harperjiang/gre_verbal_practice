//
//  VocabQuizInfoController.m
//  GRE Verbal Master
//
//  Created by Harper on 1/28/15.
//  Copyright (c) 2015 Hao Jiang. All rights reserved.
//

#import "QuizInfoController.h"
#import "UIUtils.h"

@interface QuizInfoController ()

@end

@implementation QuizInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    self.modalPresentationStyle = UIModalPresentationFormSheet;
    self.view.backgroundColor = [UIUtils backgroundColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        self.onDismiss(self,nil);
    }];
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
