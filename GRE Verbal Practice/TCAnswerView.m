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

-(void) setOptions:(NSArray *)options {
    self->_options = options;
    [self refresh];
}

-(void) refresh {
    // Remove all subviews
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // Add options
    NSInteger x = 20;
    NSInteger y = 20;
    NSInteger ystep = [UIUtils getDefaultTextboxHeight];
    NSInteger ymax = 0;
    GRETextButton* sizeEstimator = [[GRETextButton alloc] init];
    
    for(int i = 0 ; i < self.options.count;i++) {
        NSArray* sub = (NSArray*)[self.options objectAtIndex:i];
        NSInteger maxLength = 0;
        
        for(int j = 0 ; j < sub.count; j++) {
            [sizeEstimator setText:(NSString*) [sub objectAtIndex:j]];
            CGSize estimated = [sizeEstimator getPreferredSize];
            maxLength = MAX(maxLength, estimated.width);
        }
        GREButtonGroup* group = [[GREButtonGroup alloc] init];
        [self->_groups addObject:group];
        for(int j = 0 ; j < sub.count; j++) {
            CGRect frame = CGRectMake(x, y, maxLength, ystep);
            
            GRETextButton* textbutton = [[GRETextButton alloc] initWithFrame:frame];
            [textbutton addButtonListener:self];
            [textbutton setText:(NSString*) [sub objectAtIndex:j]];
            [textbutton setTag: i*100 + j];
            [self addSubview:textbutton];
            [group add:textbutton];
            y += ystep;
        }
        x += maxLength;
        x += 20;
        ymax = MAX(ymax, y);
        y = 20;
    }
    [self setPreferredSize:CGSizeMake(x,ymax)];
    
    if(widthConstraint != nil) {
        [self removeConstraints:widthConstraint];
    }
    if(heightConstraint != nil) {
        [self removeConstraints:heightConstraint];
    }
    
    NSDictionary *viewsDictionary = @{@"answerView":self};
    NSString* widthString = [NSString stringWithFormat:@"H:[answerView(%ld)]", (long)x];
    widthConstraint = [NSLayoutConstraint constraintsWithVisualFormat: widthString options:0 metrics:nil views:viewsDictionary];
    [self addConstraints:widthConstraint];
    
    NSString* heightString = [NSString stringWithFormat:@"V:[answerView(%ld)]", (long)ymax];
    heightConstraint = [NSLayoutConstraint constraintsWithVisualFormat: heightString options:0 metrics:nil views:viewsDictionary];
    [self addConstraints:heightConstraint];

    
    [self setNeedsDisplay];
}

- (void)showAnswer:(NSArray*)answers {
    for(int i = 0 ; i < answers.count;i++) {
        NSInteger answer = [(NSNumber*)[answers objectAtIndex:i] integerValue];
        GREButton* button = [[(GREButtonGroup*)[self->_groups objectAtIndex:i] buttons] objectAtIndex:answer];
        [button setRightAnswer:true];
    }
}

- (void)buttonChanged:(id)source chosen:(BOOL)chosen {
    NSMutableArray* results = [[NSMutableArray alloc] init];
    for(int i = 0 ; i < self->_groups.count; i++) {
        GREButtonGroup* group = (GREButtonGroup*)[self->_groups objectAtIndex:i];
        NSInteger result = -1;
        if(group.chosen != nil){
            result = group.chosen.tag;
        }
        [results addObject: [[NSNumber alloc] initWithInteger: result]];
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
