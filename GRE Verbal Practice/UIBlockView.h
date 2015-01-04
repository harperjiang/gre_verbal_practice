//
//  UIBlockView.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/31/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBlockItem : NSObject

@property(nonatomic) NSString* name;
@property(nonatomic) UIImage* image;
@property(nonatomic) id target;
@property(nonatomic) SEL method;
@property(nonatomic) id param;

@end

@interface BlockButton : UIButton

@end

@interface UIBlockView : UIView {
    NSMutableArray* _items;
    BOOL _inited;
}

@property(nonatomic, weak) UIView* ownerView;
@property(nonatomic) NSInteger columns;
@property(nonatomic) CGFloat hMargin;
@property(nonatomic) CGFloat vMargin;
@property(nonatomic) CGFloat hInset;
@property(nonatomic) CGFloat vInset;
@property(nonatomic, readonly) CGSize expected;
@property(nonatomic) UIFont* font;

- (void)addItem:(NSString*) name image:(UIImage*)image
         target:(id)target method:(SEL)method param:(id)param;

@end
