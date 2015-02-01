//
//  ExtendView.m
//  GRE Verbal Master
//
//  Created by Harper on 2/1/15.
//  Copyright (c) 2015 Hao Jiang. All rights reserved.
//

#import "ExtendView.h"

@implementation ExtendView

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"GradeView"
                                              owner:self
                                            options:nil] objectAtIndex:0];
    }
    return self;
}


- (void)onTap:(id)sender {
    if(self.heightConstraint.constant != 0) {
        // Shrink
        self.heightConstraint.constant = 0;
    } else {
        // Extend
        CGSize size = [self.extendView sizeThatFits:CGSizeMake(self.bounds.size.width, 10000)];
        self.heightConstraint.constant = size.height;
    }
}

@end
