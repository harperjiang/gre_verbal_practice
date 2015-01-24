//
//  PieChartView.h
//  GRE Verbal Master
//
//  Created by Harper on 1/20/15.
//  Copyright (c) 2015 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PieChartDataSource <NSObject>

- (NSInteger)numOfSections;
- (double)percentOfSection: (NSInteger) section;

@optional
- (UIColor*)colorOfSection: (NSInteger) section;
- (NSString*)titleOfSection: (NSInteger) section;
@end

@interface PieChartView : UIView {
    NSMutableArray* _colors;
    
    CGPoint _center;
    CGFloat _radius;
    CGFloat _start;
    CGFloat *_seps;
    CGFloat _count;
    
    NSInteger _selected;
}

@property(nonatomic) NSInteger margin;
@property(nonatomic) id<PieChartDataSource> dataSource;
@property(nonatomic) UILabel* textLabel;

@end
