//
//  MessageViewController.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/17/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "QViewController.h"

@interface MessageViewController : UIViewController<QViewController>

@property(nonatomic, readwrite, strong) IBOutlet UILabel* messageLabel;

@end
