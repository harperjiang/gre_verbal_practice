//
//  SettingViewController.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/18/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController

@property(nonatomic, readwrite, strong) IBOutlet UISlider* vocabDailySlider;
@property(nonatomic, readwrite, strong) IBOutlet UITextField* vocabDailyText;

-(IBAction)sliderValueChanged:(id)sender;

@end
