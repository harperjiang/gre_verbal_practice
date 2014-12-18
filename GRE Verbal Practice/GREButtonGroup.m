//
//  GREButtonGroup.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/15/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "GREButtonGroup.h"

@implementation GREButtonGroup

-(id) init {
    self = [super init];
    if(self) {
        self.chosen = nil;
        self.buttons = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void) add:(GREButton *)button {
    [self.buttons addObject:button];
    [button addButtonListener:self];
}

-(void) buttonChanged:(id) source chosen:(BOOL) chosen {
    GREButton* btn = (GREButton*)source;
    if(chosen) {
        if(self.chosen != nil) {
            [self.chosen setChosen:false];
        }
        self.chosen = btn;
    }
}

@end
