//
//  UIBlockView.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/31/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "UIBlockView.h"

@implementation UIBlockItem

@end

@implementation BlockButton

@end

@implementation UIBlockView

- (void) setup {
    self->_items = [[NSMutableArray alloc] init];
    self->_inited = NO;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self setup];
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self setup];
    }
    return self;
}

// This Container view layout subviews

- (void) addItem:(NSString *)name image:(UIImage *)image target:(id)target
          method:(SEL)method param:(id)param {
    UIBlockItem *item = [[UIBlockItem alloc] init];
    item.name = name;
    item.image = image;
    item.target = target;
    item.method = method;
    item.param = param;
    [self->_items addObject:item];
}

- (void)layoutSubviews {
    if(!_inited) {
        [self initSubview];
    }
    CGRect bounds = self.ownerView.bounds;
    CGFloat width = bounds.size.width;
    // Determine dimensions
    CGFloat boxWidth = (width - 2* self.hMargin - (self.columns - 1)* self.hInset)/self.columns;
    CGFloat labelHeight =  40;
    CGFloat heightMax = 0;
    for(int i = 0 ; i < _items.count ; i++) {
        UIButton *button = (UIButton*)[self.subviews objectAtIndex:2*i];
        NSInteger row = i / self.columns;
        NSInteger column = i % self.columns;
        CGFloat y = self.vMargin + row * (boxWidth + labelHeight + self.vInset);
        CGFloat x = self.hMargin + column * (boxWidth + self.hInset);
        
        CGRect expect = CGRectMake(x, y, boxWidth, boxWidth);
        button.frame = expect;
        
        UILabel *label = (UILabel*)[self.subviews objectAtIndex:2*i+1];
        
        CGSize fit = [label sizeThatFits:CGSizeMake(boxWidth + 2* self.hInset,30)];
        
        label.frame = CGRectMake(x + boxWidth/2 - fit.width / 2, y + boxWidth + 10, fit.width, fit.height);
        heightMax = MAX(heightMax, y + boxWidth + 10 + fit.height);
    }
    
    self->_expected = CGSizeMake(width, heightMax);
}

- (void)onButtonClick:(id)sender {
    NSUInteger index = [self.subviews indexOfObject:sender];
    if(index != NSNotFound) {
        UIBlockItem* item = (UIBlockItem*)[self->_items objectAtIndex:index/2];
        
        IMP imp = [item.target methodForSelector:item.method];
        if(item.param != nil) {
            void (*func)(id, SEL, id, id) = (void *)imp;
            func(item.target, item.method, sender, item.param);
        } else {
            void (*func)(id, SEL, id) = (void *)imp;
            func(item.target, item.method, sender);
        }
    }
}

- (void)onLabelTouch:(id)sender {
    UIView* view = [(UIGestureRecognizer*)sender view];
    NSUInteger index = [self.subviews indexOfObject:view];
    if(index != NSNotFound) {
        UIButton* button = (UIButton*)[self.subviews objectAtIndex:index-1];
        [button sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)initSubview {
    for(int i = 0 ; i < _items.count ; i++) {
        UIBlockItem *item = [self->_items objectAtIndex:i];
        
        CGRect expect = CGRectMake(0, 0, 10, 10);
        BlockButton* button = [[BlockButton alloc] initWithFrame:expect];
        [button.imageView setContentMode:UIViewContentModeScaleToFill];
        [button setImage:item.image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview: button];
        
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:expect];
        titleLabel.numberOfLines = 0;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor darkGrayColor];
        titleLabel.text = item.name;
        titleLabel.font = self.font;
        titleLabel.userInteractionEnabled = YES;
        
        UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onLabelTouch:)];
        gesture.numberOfTapsRequired = 1;
        [titleLabel addGestureRecognizer:gesture];
        [self addSubview:titleLabel];
    }
    self->_inited = YES;
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}


@end
