//
//  RCAnswerView.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/15/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCAnswerView : UIView {
    NSArray* widthConstraint;
    NSArray* heightConstraint;
}

@property(nonatomic,readwrite,retain) NSArray* options;

- (void)showAnswers:(NSArray*)answers;

@end
