//
//  AdBannerSupport.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/18/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <iAd/iAd.h>


@interface AdBannerSupport : NSObject<ADBannerViewDelegate> {
    BOOL _loaded;
    ADBannerView* _bannerView;
}

@property(nonatomic, readwrite, weak) UIView* parentView;
@property(nonatomic, readwrite, weak) UIView* shrinkView;
@property(nonatomic, readwrite, weak) NSLayoutConstraint* bottomConstraint;

- (void)layoutAnimated:(BOOL)animate;

@end
