//
//  GradeView.h
//  GRE Verbal Master
//
//  Created by Harper on 1/22/15.
//  Copyright (c) 2015 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GradientView.h"


@interface GradeView : UIView

@property(nonatomic) IBOutlet UILabel* textLabel;
@property(nonatomic) IBOutlet GradientView* gradientView;

- (void)setGrade:(NSString*)grade;

@end
