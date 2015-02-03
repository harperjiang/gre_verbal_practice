//
//  ExtendView.m
//  GRE Verbal Master
//
//  Created by Harper on 2/1/15.
//  Copyright (c) 2015 Hao Jiang. All rights reserved.
//

#import "ExtendView.h"

@implementation ExtendView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _innerView = [[[NSBundle mainBundle] loadNibNamed:@"ExtendView"
                                              owner:self
                                            options:nil] objectAtIndex:0];
        [self addSubview:_innerView];
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self setBackgroundColor:[UIColor clearColor]];
//        [_innerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _innerView = [[[NSBundle mainBundle] loadNibNamed:@"ExtendView"
                                              owner:self
                                            options:nil] objectAtIndex:0];
        [self addSubview:_innerView];
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self setBackgroundColor:[UIColor clearColor]];
//        [_innerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return self;
}

- (void)layoutSubviews {
    _innerView.frame = self.bounds;
    [_innerView layoutSubviews];
}


- (void)onTap:(id)sender {
    if (self.extendView != nil) {
        if (self.extendView.superview == nil) {
            // Install
            [_innerView addSubview:self.extendView];
            NSDictionary* dict = @{@"extendView":self.extendView, @"mainLabel":self.mainLabel};
            NSMutableArray* array = [[NSMutableArray alloc] init];
            [array addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[mainLabel]-0-[extendView]-|" options:0 metrics:nil views:dict]];
            [array addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[extendView]-0-|" options:0 metrics:nil views:dict]];
            
            CGSize expected = [self.extendView sizeThatFits:CGSizeMake(self.bounds.size.width,10000)];
            NSString* format = [NSString stringWithFormat:@"V:[extendView(==%f)]", expected.height];
            [array addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:format
                                                                               options:0
                                                                               metrics:nil
                                                                                 views:dict]];
            _extendConstraint = array;
            [_innerView addConstraints:_extendConstraint];
        } else {
            // Uninstall
            [self.extendView removeFromSuperview];
            [_innerView removeConstraints:_extendConstraint];
        }
        [self setNeedsLayout];
    }
}

@end
