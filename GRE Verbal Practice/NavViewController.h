//
//  NavViewController.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/16/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdBannerSupport.h"

@interface NavViewController : UINavigationController<AdBannerTarget> {
    AdBannerSupport* _adSupport;
}

@end
