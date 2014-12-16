//
//  GRETextButton.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/14/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GREButton.h"

@interface GRETextButton : GREButton

@property(nonatomic, readwrite, retain) NSString* text;


-(CGSize) getPreferredSize;

@end
