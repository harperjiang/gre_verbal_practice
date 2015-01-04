//
//  TCAnswerView.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/14/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "TCAnswerView.h"
#import "GRETextButton.h"
#import "GREButtonGroup.h"
#import "UIUtils.h"

@implementation TCAnswerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setOptions:(NSArray *)options {
    if(self->_options != nil && [self->_options isEqualToArray:options]) {
        return;
    }
    self->_options = options;
    self->_answers = nil;
    [self updateControls];
    // Should clear answer when option changed
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
    [self->_groups removeAllObjects];
    for(int i = 0 ; i < self.options.count;i++) {
        NSArray* sub = (NSArray*)[self.options objectAtIndex:i];
        
        GREButtonGroup* group = [[GREButtonGroup alloc] init];
        [self->_groups addObject:group];
        for(int j = 0 ; j < sub.count; j++) {
            CGRect frame = CGRectMake(0, 0, 100, 20);
            
            GRETextButton* textbutton = [[GRETextButton alloc] initWithFrame:frame];
            [textbutton addButtonListener:self];
            [textbutton setText:(NSString*) [sub objectAtIndex:j]];
            [textbutton setTag: i*100 + j + 1];
            [self addSubview:textbutton];
            [group add:textbutton];
        }
    }
    [self showAnswer];
}

- (void)refresh {
    if(self.preferredWidth == 0)
        return;
    if(self.subviews == nil || self.subviews.count == 0)
        return;
    if(!self->_dirty) {
        return;
    }
    // Add options
    NSInteger x = 20;
    NSInteger y = 20;
    NSInteger ystep = [UIUtils getDefaultTextboxHeight];
    NSInteger ymax = 0;
    NSInteger yrow = 20;
    
    GRETextButton* sizeEstimator = [[GRETextButton alloc] init];
    for(int i = 0 ; i < self.options.count;i++) {
        NSArray* sub = (NSArray*)[self.options objectAtIndex:i];
        NSInteger maxLength = 0;
        
        for(int j = 0 ; j < sub.count; j++) {
            [sizeEstimator setText:(NSString*) [sub objectAtIndex:j]];
            CGSize estimated = [sizeEstimator getPreferredSize];
            maxLength = MAX(maxLength, estimated.width);
        }
        // If size is more than width, change to next line
        if(x + maxLength > self.preferredWidth) {
            // Change Line
            x = 20;
            y = ymax + 20;
            yrow = y;
        }
        
        for(int j = 0 ; j < sub.count; j++) {
            CGRect frame = CGRectMake(x, y, maxLength, ystep);
            GRETextButton* textbutton = (GRETextButton*)[self viewWithTag:i*100+j+1];
            textbutton.frame = frame;
            y += ystep;
        }
        x += maxLength;
        x += 20;
        ymax = MAX(ymax, y);
        y = yrow;
    }
    self.preferredHeight = ymax;
    self->_dirty = NO;
}

- (void)setShouldShowAnswer:(BOOL)should {
    self->_shouldShowAnswer = should;
    [self showAnswer];
}

- (void)showAnswer {
    for(int i = 0 ; i < self.answers.count;i++) {
        NSInteger answer = [(NSNumber*)[self.answers objectAtIndex:i] integerValue];
        GREButton* button = [[(GREButtonGroup*)[self->_groups objectAtIndex:i] buttons]objectAtIndex:answer];
        [button setRightAnswer:self.shouldShowAnswer];
    }
}

- (void)showChoice:(NSArray *)choice {
    for(NSNumber* val in choice) {
        NSInteger value = [val integerValue];
        if(value != -1) {
            GREButton* button = (GREButton*)[self viewWithTag:value];
            [button setChosen:YES];
        }
    }
}

- (void)buttonChanged:(id)source chosen:(BOOL)chosen {
    NSMutableArray* results = [[NSMutableArray alloc] init];
    for(int i = 0 ; i < self->_groups.count ; i++) {
        [results addObject: [NSNumber numberWithInteger:-1]];
    }
    for(GREButton* subview in self.subviews) {
        if(subview.chosen) {
            NSInteger group = subview.tag / 100;
            [results setObject:[NSNumber numberWithInteger:subview.tag] atIndexedSubscript:group];
        }
    }
    [self.answerListener answerChanged:results];
}

- (void)setup {
    _groups = [[NSMutableArray alloc] init];
}

- (id)initWithFrame: (CGRect) frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self setup];
    }
    return self;
}


- (id)initWithCoder: (NSCoder*) decoder {
    self = [super initWithCoder:decoder];
    if(self) {
        [self setup];
    }
    return self;
}

@end
