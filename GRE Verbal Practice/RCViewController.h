//
//  RCViewController.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/15/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCQuestion.h"

@interface RCViewController : UITabBarController

@property(nonatomic, readwrite, retain) RCQuestion* questionData;

@end
