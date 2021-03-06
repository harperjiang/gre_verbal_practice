//
//  QuizReviewController.h
//  GRE Verbal Master
//
//  Created by Harper on 1/31/15.
//  Copyright (c) 2015 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VocabQuizSet.h"
#import "AdBannerSupport.h"

@interface QuizReviewController : UIViewController<AdBannerTarget>

@property(nonatomic) VocabQuizSet* quizSet;

@property(nonatomic) IBOutlet UIView* containerView;
@property(nonatomic) IBOutlet NSLayoutConstraint* containerWidth;
@property(nonatomic) IBOutlet NSLayoutConstraint* adBottomConstraint;
@property(nonatomic) IBOutlet UIScrollView* scrollView;
@end
