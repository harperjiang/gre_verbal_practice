//
//  NavViewController.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/16/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "NavViewController.h"
#import "MainViewController.h"
#import "SettingViewController.h"
#import "UpdateViewController.h"
#import "ExamResultController.h"

@interface NavViewController ()

@end

@implementation NavViewController

- (BOOL)isPad {
#ifdef UI_USER_INTERFACE_IDIOM
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
#else
    return NO;
#endif
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (BOOL)shouldAutorotate {
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations {
    if([self isPad]) {
        return UIInterfaceOrientationMaskAll;
    } else {
        id currentViewController = self.topViewController;
        if ([currentViewController isKindOfClass:[MainViewController class]])
            return UIInterfaceOrientationMaskPortrait;
        if ([currentViewController isKindOfClass:[SettingViewController class]])
            return UIInterfaceOrientationMaskPortrait;
        if ([currentViewController isKindOfClass:[UpdateViewController class]]) {
            return UIInterfaceOrientationMaskPortrait;
        }
        return UIInterfaceOrientationMaskAll;
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
