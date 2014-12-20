//
//  AdBannerSupport.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/18/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <iAd/iAd.h>


@interface AdBannerSupport : NSObject<ADBannerViewDelegate>

@property(nonatomic, readwrite, strong) ADBannerView* bannerView;
@property(nonatomic, readwrite, strong) NSLayoutConstraint* bottomConstraint;

- (void)showBanner:(BOOL)show;
@end
