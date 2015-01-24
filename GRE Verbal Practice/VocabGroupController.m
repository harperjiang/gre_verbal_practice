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
    NSInteger section = indexPath.section;
    NSInteger index = indexPath.row;
    
    if(section == 0) {
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
    if(section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FixedCell"];
        if(cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"FixedCell"];
            cell.textLabel.font = [UIFont systemFontOfSize:16];
            cell.backgroundColor = [UIColor clearColor];
            cell.accessoryType = UITableViewCellAccessoryDetailButton;
        }
        switch(index) {
            case 0:
                cell.textLabel.text = @"Visit Update Site";
            default:
                break;
        }
        return cell;
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0) {
        return self.vocabGroups.count;
    }
    if(section == 1) {
        return 1;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch(indexPath.section) {
        case 0: {
            VocabViewController* evc = (VocabViewController*)[self.storyboard instantiateViewControllerWithIdentifier: @"VocabViewController"];
            VocabGroup* selectedGroup = (VocabGroup*)[self.vocabGroups objectAtIndex:indexPath.row];
            
            VocabPlan* plan = [VocabPlan create:selectedGroup];
            evc.plan = plan;
            [self showViewController:evc sender:nil];
            break;
        }
        case 1: {
            switch(indexPath.row) {
                case 0: {
                    UIViewController* updateController = [self.storyboard instantiateViewControllerWithIdentifier:@"UpdateViewController"];
                    [self.navigationController pushViewController:updateController animated:YES];
                    break;
                }
                default: {
                    break;
                }
            }
            break;
        }
        default: {
            
        }
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(section == 1) {
        return @"More Vocabulary Sets";
    }
    return nil;
}

@end
