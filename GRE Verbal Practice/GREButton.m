//
//  GREButton.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/14/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "GREButton.h"

@implementation GREButton

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self setChosen: !self.chosen];
}

- (void) setChosen:(BOOL)chosen {
    BOOL old = [self chosen];
    self->_chosen = chosen;
    if(chosen != old) {
        [self setNeedsDisplay];
    }
}

@end
