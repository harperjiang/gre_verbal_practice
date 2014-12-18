//
//  TCAnswerView.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/14/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCAnswerView : UIView {
    NSMutableArray* _groups;
    NSArray* widthConstraint;
    NSArray* heightConstraint;
}

@property(nonatomic, readwrite, retain) NSArray* options;
@property(nonatomic, readwrite) CGSize preferredSize;

- (void)showAnswer:(NSArray*)answer;

@end
