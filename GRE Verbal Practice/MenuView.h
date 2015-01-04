//
//  ExamMenuTableViewController.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/27/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MenuItem : NSObject

@property(nonatomic,strong) NSString* title;
@property(nonatomic,strong) UIImage* image;
@property(nonatomic,weak) id target;
@property(nonatomic) SEL action;

@end

@interface MenuCell : UITableViewCell
@end


@interface MenuView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic) BOOL show;
@property(nonatomic, weak) UIView* mainView;
@property(nonatomic) id<UITableViewDataSource> externalDataSource;
@property(nonatomic) id<UITableViewDelegate> externalDelegate;

- (void)addButton:(NSString*)title image:(UIImage*)image target:(id) target action:(SEL)action;
- (void)toggleMenu:(id)sender event:(UIEvent*) event;

@end
