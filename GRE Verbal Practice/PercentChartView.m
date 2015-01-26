//
//  PercentChartView.m
//  GRE Verbal Master
//
//  Created by Harper on 1/24/15.
//  Copyright (c) 2015 Hao Jiang. All rights reserved.
//

#import "PercentChartView.h"
#import "UIUtils.h"

#define COLOR(x) ((double)x)/255

@implementation PercentChartView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.label.font = [UIFont systemFontOfSize:12];
    self.label.backgroundColor = [UIColor clearColor];
    self.label.textColor = [UIColor darkGrayColor];
    self.label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.label];
}

- (void)layoutSubviews {
    [self.label setFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
}

- (void)setPercent:(double)percent {
    self->_percent = percent;
    NSString* percentText = [NSString stringWithFormat:@"%zd%%", (int)(self.percent*100)];
    [self.label setText:percentText];
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    //UIColor* red = [UIColor colorWithRed:COLOR(239) green:COLOR(113) blue:COLOR(98) alpha:1];
    //UIColor* yellow = [UIColor colorWithRed:COLOR(252) green:COLOR(214) blue:COLOR(48) alpha:1];
    //UIColor* green = [UIColor colorWithRed:COLOR(95) green:COLOR(191) blue:COLOR(96) alpha:1];
    
    CGFloat br,bg,bb,er,eg,eb;
    CGFloat lambda;
    if(self.percent <= 0.5) {
        lambda = 2 * self.percent;
        br = 239;
        bg = 113;
        bb = 98;
        er = 252;
        eg = 214;
        eb = 48;
    } else {
        lambda = (self.percent - 0.5)*2;
        br = 252;
        bg = 214;
        bb = 48;
        er = 95;
        eg = 191;
        eb = 96;
    }
    UIColor* color = [UIColor colorWithRed:COLOR((1-lambda)*br+lambda*er)
                                     green:COLOR((1-lambda)*bg+lambda*eg)
                                      blue:COLOR((1-lambda)*bb+lambda*eb)
                                     alpha:1];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextStrokeRect(context, rect);
    CGContextFillRect(context, CGRectMake(rect.origin.x,rect.origin.y,rect.size.width*self.percent,rect.size.height));
    
    CGContextRestoreGState(context);
}


@end
