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
#import "UIBlockView.h"

@interface MainViewController : UIViewController {

}

@property(nonatomic) IBOutlet UIView* titleView;
@property(nonatomic) IBOutlet UIScrollView* scrollView;
@property(nonatomic) IBOutlet UIBlockView* blockView;
@property(nonatomic) IBOutlet NSLayoutConstraint* bottomConstraint;

@property(nonatomic) IBOutlet NSLayoutConstraint* widthConstraint;
@property(nonatomic) IBOutlet NSLayoutConstraint* heightConstraint;


- (IBAction)importData:(id)sender;

@end
