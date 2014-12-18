//
//  RCAnswerView.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/15/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "RCAnswerView.h"
#import "GRERadioButton.h"
#import "GREButtonGroup.h"

@implementation RCAnswerView {
    GREButtonGroup* group;
}


-(void) setOptions:(NSArray *)options {
    self->_options = options;
    
    [self refresh];
}

- (void) refresh {
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // Generate new items
    
    NSInteger MARGIN = 20;
    NSInteger INTERCELL = 10;
    
    
    NSInteger x = MARGIN;
    NSInteger y = MARGIN;
    
    NSInteger BOX_SIZE = 20;
    
    NSInteger maxX = 0;
    
    group = [[GREButtonGroup alloc] init];
    
    for(int i = 0 ; i < self.options.count; i++) {
        
        NSString* option = [self.options objectAtIndex:i];
        
        CGRect frame = CGRectMake(x, y, BOX_SIZE, BOX_SIZE);
        GRERadioButton* radio = [[GRERadioButton alloc] initWithFrame:frame];
        [group add:radio];
        [self addSubview:radio];
        
        x += BOX_SIZE + INTERCELL;
        
        UILabel* label = [[UILabel alloc] initWithFrame:frame];
        [label setNumberOfLines:0];
        CGRect superframe = self.superview.bounds;
        label.frame = CGRectMake(x,
                                 y,
                                 MAX(350,superframe.size.width),
                                 0);
        
        [label setText:option];
        [label sizeToFit];
        
        CGSize bestSize = label.frame.size;
        
        [label setText:option];
        [self addSubview: label];
        
        maxX = MAX(maxX, x + bestSize.width);
        
        y += MAX(bestSize.height, 20);
        y += INTERCELL;
        x = MARGIN;
    }
    
    if(widthConstraint != nil) {
        [self removeConstraints:widthConstraint];
    }
    if(heightConstraint != nil) {
        [self removeConstraints:heightConstraint];
    }
    NSDictionary *viewsDictionary = @{@"answerView":self};
    NSString* widthString = [NSString stringWithFormat:@"H:[answerView(%ld)]", (long)maxX];
    widthConstraint = [NSLayoutConstraint constraintsWithVisualFormat: widthString options:0 metrics:nil views:viewsDictionary];
    [self addConstraints:widthConstraint];
    
    NSString* heightString = [NSString stringWithFormat:@"V:[answerView(%ld)]", (long)y];
    heightConstraint = [NSLayoutConstraint constraintsWithVisualFormat: heightString options:0 metrics:nil views:viewsDictionary];
    [self addConstraints:heightConstraint];
    
    [self setNeedsDisplay];

}

- (void)showAnswers:(NSArray *)answers {
    for(int i = 0 ; i < answers.count ; i++) {
        NSInteger index = [(NSNumber*)[answers objectAtIndex:i] integerValue];
        [(GREButton*)[self->group.buttons objectAtIndex:index] setRightAnswer:YES];
    }
}

@end
