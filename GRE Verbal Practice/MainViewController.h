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

@interface MainViewController : UIViewController {
    ADBannerView* _bannerView;
}

@property(nonatomic, readwrite, strong) AdBannerSupport* adSupport;

- (IBAction)importData:(id)sender;

@end
