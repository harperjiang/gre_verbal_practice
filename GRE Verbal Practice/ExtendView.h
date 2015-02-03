//
//  ExtendView.h
//  GRE Verbal Master
//
//  Created by Harper on 2/1/15.
//  Copyright (c) 2015 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface ExtendView : UIView {
    UIView* _innerView;
    NSArray* _extendConstraint;
}

@property(nonatomic) IBOutlet UILabel* mainLabel;
@property(nonatomic) IBOutlet UILabel* explainLabel;
@property(nonatomic) IBOutlet UIImageView* imageView;

@property(nonatomic) UIView* extendView;

- (IBAction)onTap:(id)sender;

@end
