//
//  GREButton.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/14/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "GREButton.h"
#import "WeakRef.h"

@implementation GREButton

- (id)init {
    self = [super init];
    if(self) {
        self.listeners = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self setChosen: !self.chosen];
}

- (void)addButtonListener:(id<ButtonListener>) listener {
    WeakRef* ref = [[WeakRef alloc] init];
    ref.reference = listener;
    [self.listeners addObject: ref];
}

- (void)fireChosen:(BOOL) chosen {
    for(int i = 0 ; i < self.listeners.count ; i++) {
        WeakRef* ref = (WeakRef*)[self.listeners objectAtIndex:i];
        if(ref.reference != nil) {
            [(id<ButtonListener>)ref.reference buttonChanged: self chosen: chosen];
        }
    }
}

- (void) setChosen:(BOOL)chosen {
    BOOL old = [self chosen];
    self->_chosen = chosen;
    if(chosen != old) {
        [self setNeedsDisplay];
        [self fireChosen:chosen];
    }
}

- (void) setRightAnswer:(BOOL)rightAnswer {
    BOOL old = [self rightAnswer];
    self->_rightAnswer = rightAnswer;
    if(rightAnswer != old) {
        [self setNeedsDisplay];
    }
}

@end
