//
//  VocabGroupController.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/30/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "VocabGroupController.h"
#import "VocabViewController.h"
#import "VocabGroup.h"
#import "VocabPlan.h"
#import "DataManager.h"
#import "UIUtils.h"

@interface VocabGroupController ()

@end

@implementation VocabGroupController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIUtils backgroundColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = [indexPath row];
    
    VocabGroup* group = [self.vocabGroups objectAtIndex:index];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DefaultCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"DefaultCell"];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.backgroundColor = [UIColor clearColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:10];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    [cell.textLabel setText: group.name];
    [cell.detailTextLabel setText:group.detail];
    // cell.imageView.image = theImage;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0)
        return self.vocabGroups.count;
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    VocabViewController* evc = (VocabViewController*)[self.storyboard instantiateViewControllerWithIdentifier: @"VocabViewController"];
    VocabGroup* selectedGroup = (VocabGroup*)[self.vocabGroups objectAtIndex:indexPath.row];
    
    VocabPlan* plan = [VocabPlan create:selectedGroup];
    evc.plan = plan;
    [self showViewController:evc sender:nil];
}

@end
