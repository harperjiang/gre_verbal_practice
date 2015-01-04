//
//  RCAnswerView.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/15/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "RCAnswerView.h"
#import "GRERadioButton.h"
#import "GREChoiceBox.h"
#import "GREButtonGroup.h"

@implementation RCAnswerView {
    GREButtonGroup* group;
}


- (void)setOptions:(NSArray *)options multiple:(BOOL)multiple{
    if(self.options != nil && [options isEqualToArray: self.options]) {
        return;
    }
    self->_options = options;
    self->_answers = nil;
    self->_multiple = multiple;
    [self updateControls];
    self->_dirty = YES;
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
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if(!self.multiple) {
        group = [[GREButtonGroup alloc] init];
    } else {
        group = nil;
    }
    NSInteger BOX_SIZE = 20;
    CGRect frame = CGRectMake(0, 0, BOX_SIZE, BOX_SIZE);
    for(int i = 0 ; i < self.options.count; i++) {
        NSString* option = [self.options objectAtIndex:i];
        if(self.multiple) {
            GREChoiceBox* choice = [[GREChoiceBox alloc] initWithFrame:frame];
            [choice addButtonListener:self];
            [choice setTag:i+1];
            [self addSubview:choice];
        } else {
            GRERadioButton* radio = [[GRERadioButton alloc] initWithFrame:frame];
            [radio addButtonListener:self];
            [radio setTag:i+1];
            [group add:radio];
            [self addSubview:radio];
        }
        UILabel* label = [[UILabel alloc] initWithFrame:frame];
        [label setNumberOfLines:0];
        [label setText:option];
        [self addSubview: label];
    }
    [self showAnswer];
}

- (void) refresh {
    NSInteger MARGIN = 20;
    NSInteger INTERCELL = 10;
    
    
    NSInteger x = MARGIN;
    NSInteger y = MARGIN;
    
    NSInteger BOX_SIZE = 20;
    
    for(int i = 0 ; i < self.options.count; i++) {
        CGRect frame = CGRectMake(x, y, BOX_SIZE, BOX_SIZE);
        GRERadioButton* radio = [self.subviews objectAtIndex:2*i];
        radio.frame = frame;
        
        x += BOX_SIZE + INTERCELL;
        
        UILabel* label = [self.subviews objectAtIndex:2*i+1];
        
        [label setPreferredMaxLayoutWidth:self.preferredWidth - x];
        CGSize labelSize = [label sizeThatFits:CGSizeMake(label.preferredMaxLayoutWidth, 1000)];
        
        frame = CGRectMake(x, y, labelSize.width, labelSize.height);
        label.frame = frame;
        
        y += MAX(labelSize.height, BOX_SIZE);
        y += INTERCELL;
        x = MARGIN;
    }
    [self setPreferredHeight:y];
    
    self->_dirty = NO;
}

- (void)setShouldShowAnswer:(BOOL)should {
    self->_shouldShowAnswer = should;
    [self showAnswer];
}

- (void)showAnswer {
    for(int i = 0 ; i < self.answers.count ; i++) {
        NSInteger index = [(NSNumber*)[self.answers objectAtIndex:i] integerValue];
        [(GREButton*)[self->group.buttons objectAtIndex:index] setRightAnswer:self.shouldShowAnswer];
    }
}

- (void)showChoice:(NSArray *)choice {
    for(NSNumber* num in choice) {
        NSInteger value = [num integerValue];
        GREButton* btn = (GREButton*)[self viewWithTag:value];
        [btn setChosen:YES];
    }
}

- (void)buttonChanged:(id)source chosen:(BOOL)chosen {
    NSMutableArray* results = [[NSMutableArray alloc] init];
    if(self.multiple) {
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
    } else {
        GREButton* btn = (GREButton*)source;
        if(btn.chosen) {
            [results addObject: [NSNumber numberWithInteger: btn.tag]];
            [self.answerListener answerChanged:results];
        }
    }
}

@end
