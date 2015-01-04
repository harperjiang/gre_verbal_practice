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
    [self layoutAnimated:YES];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    NSLog(@"%@:%@",error,[error userInfo]);
    [self layoutAnimated:YES];
}


- (void)layoutAnimated:(BOOL)animated {
    CGRect contentFrame = self.parentView.bounds;
    
    // all we need to do is ask the banner for a size that fits into the layout area we are using
    CGSize sizeForBanner = [_bannerView sizeThatFits:contentFrame.size];
    
    // compute the ad banner frame
    CGRect bannerFrame = _bannerView.frame;
    CGFloat newbottomDist = 0;
    if (_bannerView.bannerLoaded) {
        
        // bring the ad into view
        contentFrame.size.height -= sizeForBanner.height;   // shrink down content frame to fit the banner below it
        bannerFrame.origin.y = contentFrame.size.height;
        bannerFrame.size.height = sizeForBanner.height;
        bannerFrame.size.width = sizeForBanner.width;
        
        // if the ad is available and loaded, shrink down the content frame to fit the banner below it,
        // we do this by modifying the vertical bottom constraint constant to equal the banner's height
        newbottomDist = sizeForBanner.height;
        _loaded = YES;
    } else {
        // hide the banner off screen further off the bottom
        bannerFrame.origin.y = contentFrame.size.height;
        newbottomDist = 0;
        _loaded = NO;
    }
    
    [UIView animateWithDuration:animated ? 0.25 : 0.0 animations:^{
//        if(self.shrinkView != nil) {
//            self.shrinkView.frame = contentFrame;
//            [self.shrinkView layoutIfNeeded];
//        }
        self.bannerView.frame = bannerFrame;
        if(nil != self.bottomConstraint) {
            self.bottomConstraint.constant = newbottomDist;
        }
        self.bannerView.hidden = !_bannerView.bannerLoaded;
    }];
}

@end
