//
//  AdBannerSupport.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/18/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "AdBannerSupport.h"

@implementation AdBannerSupport

- (void)setBannerView:(ADBannerView *)bannerView {
    self->_bannerView = bannerView;
    [self->_bannerView setDelegate:self];
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave {
    return YES;
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner {
    
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    [self showBanner:YES];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    [self showBanner:NO];
}


- (void)showBanner:(BOOL)show {
    NSInteger newcon = self.bannerView.bannerLoaded?
    0:-self.bannerView.bounds.size.height;
    
    [UIView animateWithDuration:
        0.25
        animations:^{
            //[self.bannerView setHidden:!show];
            self.bottomConstraint.constant = newcon;
        }
        completion: nil];
}


@end
