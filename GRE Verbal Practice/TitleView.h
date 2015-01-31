//
//  ScoreView.h
//  GRE Verbal Master
//
//  Created by Harper on 1/29/15.
//  Copyright (c) 2015 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GradientView.h"

@interface TitleView : UIView

@property(nonatomic) IBOutlet UILabel* titleLabel;
@property(nonatomic) IBOutlet UILabel* scoreLabel;
@property(nonatomic) IBOutlet GradientView* gradientView;

@property(nonatomic) IBOutlet UIView* view;

@end
