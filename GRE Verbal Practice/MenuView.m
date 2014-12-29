//
//  ExamMenuTableViewController.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/27/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "MenuView.h"

@implementation MenuItem

@end


@interface MenuView () {
    NSMutableArray* _items;
}

@end

@implementation MenuView

- (void)setup {
    self->_items = [[NSMutableArray alloc] init];
    self.backgroundColor = [UIColor colorWithRed:0.3 green:0.49 blue:0.8 alpha:1];
    self.show = NO;
    self.delegate = self;
    self.dataSource = self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if(self) {
        [self setup];
    }
    return self;
}

- (void)addButton:(NSString *)title image:(UIImage *)image target:(id)target action:(SEL)action {
    MenuItem* item = [[MenuItem alloc] init];
    item.title = title;
    item.image = image;
    item.target = target;
    item.action = action;
    
    [self->_items addObject:item];
}

- (void)toggleMenu:(id)sender event:(UIEvent*)event {
    self.show = !self.show;
    
    CGRect menuFrame = self.mainView.bounds;
    CGRect viewFrame = self.mainView.bounds;
    if(self.show) {
        CGRect buttonFrame = [[event.allTouches anyObject] view].bounds;
        CGFloat width = buttonFrame.origin.x + buttonFrame.size.width + 5;
        menuFrame.size.width -= width;
    
        UIWindow* currentWindow = [UIApplication sharedApplication].keyWindow;
        [currentWindow addSubview: self];
        
        CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
   
        menuFrame.origin.y += statusBarFrame.size.height;
        menuFrame.size.height -= statusBarFrame.size.height;
    
        viewFrame.origin.x += menuFrame.size.width;
    } else {
        menuFrame.origin.x -= menuFrame.size.width;
        viewFrame.origin.x = 0;
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = menuFrame;
        self.mainView.frame = viewFrame;
    } completion:^(BOOL completed){
        if(completed && !self.show) {
            [self removeFromSuperview];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    if(self.externalDataSource == nil)
        return 1;
    return [self.externalDataSource numberOfSectionsInTableView:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if(section == 0)
        return _items.count;
    if(self.externalDataSource != nil) {
        return [self.externalDataSource tableView:tableView numberOfRowsInSection:section];
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([indexPath indexAtPosition:0] > 0) {
        return [self.externalDataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DefaultCell"];
    if(nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DefaultCell"];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.backgroundColor = [UIColor clearColor];
    }
    MenuItem* item = (MenuItem*)[self->_items objectAtIndex:indexPath.row];
    
    cell.textLabel.text = item.title;
    cell.imageView.image = item.image;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if([indexPath indexAtPosition:0] > 0) {
        return [self.externalDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self toggleMenu:nil event:nil];
    MenuItem* item = (MenuItem*)[_items objectAtIndex:indexPath.row];
    if(item.target != nil && item.action != nil) {
        IMP imp = [item.target methodForSelector:item.action];
        void (*intervalFunc)(id, SEL, id) = (void *)imp;
        intervalFunc(item.target, item.action, self);
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(self.externalDataSource == nil)
        return nil;
    return [self.externalDataSource tableView:tableView titleForHeaderInSection:section];
}

@end
