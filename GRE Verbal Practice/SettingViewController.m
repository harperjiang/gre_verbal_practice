//
//  SettingViewController.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/18/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "SettingViewController.h"
#import "UserPreference.h"
#import "UIUtils.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIUtils backgroundColor];
    
    NSInteger vocabDaily = [UserPreference getInteger:USER_DAILY_VOCAB defval:USER_DAILY_VOCAB_DEFAULT];
    [self.vocabDailySlider setValue:vocabDaily];
    [self.vocabDailyText setText: [NSString stringWithFormat:@"%zd", vocabDaily]];
    
    NSInteger quesPerSetDaily = [UserPreference getInteger:USER_EXAM_TIMELIMIT defval:USER_EXAM_TIMELIMIT_DEFAULT];
    [self.questionPerSetSlider setValue:quesPerSetDaily];
    [self.questionPerSetText setText: [NSString stringWithFormat:@"%zd", quesPerSetDaily]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sliderValueChanged:(id)sender {
    UISlider* slider = (UISlider*)sender;
    NSInteger value = slider.value;
    if(slider == self.vocabDailySlider) {
        [self.vocabDailyText setText:[NSString stringWithFormat:@"%zd", value]];
        [UserPreference setInteger:value forKey:USER_DAILY_VOCAB];
    }
    if(slider == self.questionPerSetSlider) {
        [self.questionPerSetText setText:[NSString stringWithFormat:@"%zd", value]];
        [UserPreference setInteger:value forKey:USER_EXAM_TIMELIMIT];
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
