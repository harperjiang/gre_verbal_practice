//
//  GradientView.h
//  GRE Verbal Master
//
//  Created by Harper on 1/21/15.
//  Copyright (c) 2015 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GradientItem : NSObject

@property(nonatomic) UIColor* color;
@property(nonatomic) double location;

@end

@interface GradientView : UIView

@property(nonatomic) NSArray* colors;

@end
