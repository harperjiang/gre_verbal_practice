//
//  AboutViewController.h
//  GRE Verbal Practice
//
//  Created by Harper on 1/1/15.
//  Copyright (c) 2015 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "AdBannerSupport.h"

@interface WebButton : UIButton

@property(nonatomic) NSString* webtarget;

@end

@interface AboutViewController : UIViewController{
    
}

@property(nonatomic, readwrite, strong) IBOutlet NSLayoutConstraint* bottomConstraint;
@property(nonatomic, readwrite, strong) IBOutlet UIScrollView* scrollView;

@property(nonatomic, readwrite, strong) IBOutlet NSLayoutConstraint* widthConstraint;

@end
