//
//  GradeView.m
//  GRE Verbal Master
//
//  Created by Harper on 1/22/15.
//  Copyright (c) 2015 Hao Jiang. All rights reserved.
//

#import "GradeView.h"

@implementation GradeView

-  (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self){
        [self addSubview:
         [[[NSBundle mainBundle] loadNibNamed:@"GradeView"
                                        owner:self
                                      options:nil] objectAtIndex:0]];
        
        NSMutableArray* colors = [[NSMutableArray alloc] init];
        
        GradientItem* item = [[GradientItem alloc] init];
        item.color = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
        item.location = 0;
        [colors addObject:item];
        
//        item = [[GradientItem alloc] init];
//        item.color = [UIColor colorWithRed:0 green:1 blue:0 alpha:1];
//        item.location = 0.5;
//        [colors addObject:item];
//        
        item = [[GradientItem alloc] init];
        item.color = [UIColor colorWithRed:0 green:0 blue:1 alpha:1];
        item.location = 1;
        [colors addObject:item];
        
        [self.gradientView setColors:colors];
    }
    return self;
}

- (void)setGrade:(NSString *)grade {
    [self.textLabel setText:grade];
}

@end
