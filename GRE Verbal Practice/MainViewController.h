//
//  MainViewController.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/9/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "AdBannerSupport.h"

@interface MainViewController : UIViewController

@property(nonatomic, readwrite, strong) IBOutlet NSLayoutConstraint* adBannerBottomCon;
@property(nonatomic, readwrite, strong) IBOutlet ADBannerView* adBannerView;

@property(nonatomic, readwrite, strong) AdBannerSupport* adSupport;

@end
