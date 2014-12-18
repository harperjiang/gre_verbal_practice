//
//  GREButtonGroup.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/15/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "GREButton.h"

@interface GREButtonGroup : NSObject

@property(nonatomic, readwrite, strong) GREButton* chosen;
@property(nonatomic, readwrite, strong) NSMutableArray* buttons;

-(void) add: (GREButton*) button;
-(void) buttonChosen: (id) button;
@end
