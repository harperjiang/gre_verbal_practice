//
//  GREButton.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/14/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ButtonListener <NSObject>

- (void)buttonChanged:(id) source chosen:(BOOL)chosen;

@end

@interface GREButton : UIButton

@property(nonatomic, readwrite) BOOL chosen;
@property(nonatomic, readwrite) BOOL rightAnswer;
@property(nonatomic, readwrite, strong) NSMutableArray* listeners;

- (void)addButtonListener:(id<ButtonListener>) listener;

@end
