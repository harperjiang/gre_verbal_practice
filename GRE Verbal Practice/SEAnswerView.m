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


-(void) setOptions:(NSArray *)options {
    self->_options = options;
    [self refresh];
}


-(void) refresh {
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // Generate new items
    
    NSInteger MARGIN = 20;
    NSInteger INTERCELL = 10;
    
    
    NSInteger x = MARGIN;
    NSInteger y = MARGIN;
    
    NSInteger BOX_SIZE = 20;
    
    NSInteger maxX = 0;
    UILabel* estimator = [[UILabel alloc] init];
    for(int i = 0 ; i < self.options.count; i++) {
        
        NSString* option = [self.options objectAtIndex:i];
        
        CGRect frame = CGRectMake(x, y, BOX_SIZE, BOX_SIZE);
        GREChoiceBox* choice = [[GREChoiceBox alloc] initWithFrame:frame];
        
        [self addSubview:choice];
        
        x += BOX_SIZE + INTERCELL;
        
        CGSize bestSize = [option sizeWithFont:[estimator font]];
        frame = CGRectMake(x, y, bestSize.width, bestSize.height);
        
        UILabel* label = [[UILabel alloc] initWithFrame:frame];
        
        [label setText:option];
        [self addSubview: label];
        
        maxX = MAX(maxX, x + bestSize.width);
        
        y += 20;
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

@end
