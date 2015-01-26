//
//  PieChartView.m
//  GRE Verbal Master
//
//  Created by Harper on 1/20/15.
//  Copyright (c) 2015 Hao Jiang. All rights reserved.
//

#import "PieChartView.h"
#import "math.h"

#define COLOR(x) ((double)x)/255

@implementation PieChartView

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self setup];
    }
    return self;
}

- (void) setup {
    self.margin = 30;
    
    self->_colors = [[NSMutableArray alloc] init];
    [_colors addObject:[UIColor colorWithRed:COLOR(7) green:COLOR(182) blue:COLOR(248) alpha:1]];
    [_colors addObject:[UIColor colorWithRed:COLOR(62) green:COLOR(233) blue:COLOR(117) alpha:1]];
    [_colors addObject:[UIColor colorWithRed:COLOR(226) green:COLOR(119) blue:COLOR(50) alpha:1]];
    [_colors addObject:[UIColor colorWithRed:COLOR(230) green:COLOR(88) blue:COLOR(83) alpha:1]];
    [_colors addObject:[UIColor colorWithRed:COLOR(30) green:COLOR(73) blue:COLOR(114) alpha:1]];
    [_colors addObject:[UIColor colorWithRed:COLOR(45) green:COLOR(208) blue:COLOR(250) alpha:1]];
    [_colors addObject:[UIColor colorWithRed:COLOR(238) green:COLOR(228) blue:COLOR(91) alpha:1]];

    
    self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.textLabel setTextAlignment:NSTextAlignmentCenter];
    [self.textLabel setFont:[UIFont systemFontOfSize:14]];
    [self addSubview: self.textLabel];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
    [tap setNumberOfTapsRequired:1];
    [self addGestureRecognizer: tap];
    
    self->_start = (((double)arc4random())/0x100000000)*2*M_PI;
    self->_selected = -1;
}

void fillRing(CGContextRef context, CGColorRef color, CGFloat cx, CGFloat cy, CGFloat radius1,
              CGFloat radius2, CGFloat start, CGFloat end, BOOL mark) {
    
    CGContextSaveGState(context);
    
    if(mark) {
        // Calculate the moving vector
        CGFloat dir = (start+end)/2;
        CGFloat moving = 10;
        CGFloat mx = moving * cos(dir);
        CGFloat my = moving * sin(dir);
        
        CGContextTranslateCTM(context, mx, my);
    }
    
    CGContextMoveToPoint(context, cx + cos(start)* radius1, cy + sin(start) * radius1);
    CGContextAddArc(context, cx, cy, radius1, start, end, 0);
    CGContextAddLineToPoint(context, cx + cos(end)* radius2, cy + sin(end) * radius2);
    CGContextAddArc(context, cx, cy, radius2, end, start, 1);
    
    
    CGContextSetStrokeColorWithColor(context, color);
    
    CGContextSetFillColorWithColor(context, color);
    
    CGContextDrawPath(context, kCGPathFillStroke);
    CGContextRestoreGState(context);
}

- (void)layoutSubviews {
    CGRect rect = self.bounds;
    CGFloat width = MIN(rect.size.width - 2 * self.margin, rect.size.height - 2 * self.margin);
    
    [self.textLabel setFrame:CGRectMake(0, 2 * self.margin + width, rect.size.width, rect.size.height - 2 * self.margin - width)];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    if(self.dataSource != nil) {
        // Draw a circle in the top-middle
        CGFloat width = MIN(rect.size.width - 2 * self.margin, rect.size.height - 2 * self.margin);
        
        CGFloat cy = self.margin + width/2;
        CGFloat cx = rect.size.width/2;
        self->_center = CGPointMake(cx, cy);
        self->_radius = width/2;
        
        self->_count = [self.dataSource numOfSections];
        if(_seps != NULL) {
            free(_seps);
        }
        _seps = (CGFloat*) malloc(_count*sizeof(CGFloat));
        
        double start = self->_start;
        [self.textLabel setText:@""];
        for (int i = 0 ; i < _count ; i++) {
            UIColor* drawColor = [self randomColor:i];
            if([self.dataSource respondsToSelector:@selector(colorOfSection:)]) {
                drawColor = [self.dataSource colorOfSection:i];
            }
            if(i == _selected && [self.dataSource respondsToSelector:@selector(titleOfSection:)]) {
                [self.textLabel setText: [self.dataSource titleOfSection:i]];
            }
            
            double length = 2 * M_PI * [self.dataSource percentOfSection:i];
            
            fillRing(context, drawColor.CGColor,
                     cx, cy, _radius/2, _radius, start, length + start,i == _selected);
            
            _seps[i] = start;
            start += length;
        }
    }
    
    CGContextRestoreGState(context);
}

- (UIColor*)randomColor:(NSInteger) index {
    return [_colors objectAtIndex:index];
}

- (void) onTap:(UITapGestureRecognizer*) tap {
    // If tap on any of the rings
    CGPoint tapPoint = [tap locationInView:self];
    
    CGFloat dist = sqrt(pow(tapPoint.x - _center.x, 2) + pow(tapPoint.y - _center.y, 2));
                            
    if(dist >= _radius/2 && dist<= _radius) {
        double cosx = (tapPoint.x - _center.x) / dist;
        double sinx = (tapPoint.y - _center.y) / dist;
        
        CGFloat radian = acos(cosx);
        if(sinx < 0) {
            radian = 2 * M_PI - radian;
        }
        while(radian < _seps[0]) {
            radian += 2 * M_PI;
        }
        for(int i = 0 ; i < _count; i++) {
            if(radian >= _seps[i] && (radian <= _seps[i+1]|| i == _count - 1)) {
                // i is clicked
                _selected = (_selected == i)? -1:i;
                break;
            }
        }
        [self setNeedsDisplay];
        [UIView transitionWithView:self duration:1
                           options:UIViewAnimationOptionBeginFromCurrentState
                        animations:^{
                            [self.layer displayIfNeeded];
                        } completion:nil];
    }
    
}

@end
