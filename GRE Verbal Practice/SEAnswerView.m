//
//  SEAnswerView.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/15/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "SEAnswerView.h"
#import "GREChoiceBox.h"
#import "UIUtils.h"

@implementation SEAnswerView


- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self->buttons = [[NSMutableArray alloc] init];
    self.preferredWidth = 0;
    self->dirty = NO;
}

- (void)setOptions:(NSArray *)options {
    if(self->_options != nil && [self.options isEqualToArray:options])
        return;
    self->_options = options;
    self->_answers = nil;
    [self updateControls];
    self->dirty = YES;
    [self setNeedsLayout];
}

- (CGSize)sizeThatFits:(CGSize)size {
    self.preferredWidth = size.width;
    [self refresh];
    return CGSizeMake(self.preferredWidth, self.preferredHeight);
}

- (void)layoutSubviews {
    [self refresh];
    [super layoutSubviews];
}

- (void)updateControls {
    // Remove old controls
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self->buttons removeAllObjects];
    // Add new controls
    for(int i = 0 ; i < self.options.count; i++) {
        NSString* option = [self.options objectAtIndex:i];
        CGRect frame = CGRectMake(0, 0, 20, 20);
        GREChoiceBox* choice = [[GREChoiceBox alloc] initWithFrame: frame];
        [choice addButtonListener:self];
        [choice setTag:i+1];
        [self->buttons addObject:choice];
        [self addSubview:choice];
        
        UILabel* label = [[UILabel alloc] initWithFrame:frame];
        [label setText:option];
        [label setNumberOfLines:0];
        [self addSubview: label];
    }
    [self showAnswer];
}

- (void)refresh {
    if(self.preferredWidth == 0)
        return;
    if(self.subviews == nil || self.subviews.count == 0)
        return;
    if(!self->dirty) {
        return;
    }
    NSInteger MARGIN = 20;
    NSInteger INTERCELL = 10;
    
    
    NSInteger x = MARGIN;
    NSInteger y = MARGIN;
    
    NSInteger BOX_SIZE = 20;
    
    for(int i = 0 ; i < self.options.count; i++) {
        CGRect frame = CGRectMake(x, y, BOX_SIZE, BOX_SIZE);
        GREChoiceBox* choice = (GREChoiceBox*)[self.subviews objectAtIndex:i*2];
        choice.frame = frame;
        
        x += BOX_SIZE + INTERCELL;
        
        CGFloat remainWidth = self.preferredWidth - x;
        frame = CGRectMake(x, y, remainWidth, 1000);
        
        UILabel* label = (UILabel*)[self.subviews objectAtIndex:i*2+1];
        label.frame = frame;
        [label setPreferredMaxLayoutWidth:remainWidth];
        [label sizeToFit];
        
        y += 20;
        y += INTERCELL;
        x = MARGIN;
    }
    self.preferredHeight = y;
    self->dirty = NO;
}

- (void)setShouldShowAnswer:(BOOL)shouldShowAnswer {
    self->_shouldShowAnswer = shouldShowAnswer;
    [self showAnswer];
}

- (void)showAnswer {
    for(int i = 0 ; i < self.answers.count ;i++) {
        NSInteger index = [(NSNumber*)[self.answers objectAtIndex:i] integerValue];
        [(GREButton*)[self->buttons objectAtIndex:index] setRightAnswer: self.shouldShowAnswer];
    }
}

- (void)showChoice:(NSArray*)choice {
    for(NSNumber* val in choice) {
        NSInteger value = [val integerValue];
        [(GREButton*)[self viewWithTag:value] setChosen:YES];
    }
}

- (void)buttonChanged:(id)source chosen:(BOOL)chosen {
    NSMutableArray* results = [[NSMutableArray alloc] init];
    
    for(int i = 0 ; i < self.subviews.count ; i++) {
        UIView* sub = [self.subviews objectAtIndex:i];
        if([sub isKindOfClass:[GREChoiceBox class]]) {
            GREChoiceBox* gcb = (GREChoiceBox*)sub;
            if(gcb.chosen) {
                [results addObject: [[NSNumber alloc] initWithInteger: gcb.tag]];
            }
        }
    }
    [self.answerListener answerChanged:results];
}

@end
