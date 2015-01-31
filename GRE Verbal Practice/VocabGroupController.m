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
#import "PercentChartView.h"
#import "UIUtils.h"
#import "DateUtils.h"

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
    
    DataManager* dm = [DataManager defaultManager];
    NSDate* now = [DateUtils truncate:[NSDate date]];
    for(VocabGroup* vg in self.vocabGroups) {
        if(!(vg.updateDate == nil || [now isEqualToDate:vg.updateDate])) {
            NSInteger vocabcount = [dm getVocabCount: vg];
            NSInteger vocabDone = [dm getDoneVocabCount: vg];
            vg.percent = [NSNumber numberWithDouble:((double)vocabDone)/vocabcount];
            vg.updateDate = [DateUtils truncate:[NSDate date]];
            [dm save];
        }
    }
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view
       forSection:(NSInteger)section {
    view.tintColor = [UIUtils navbarColor];
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor whiteColor]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section > 0)
        return 28;
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger index = indexPath.row;
    
    switch (section) {
        case 0: {
            VocabGroup* group = [self.vocabGroups objectAtIndex:index];
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VocabGroupCell"];
            /*if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"VocabGroupCell"];
                cell.textLabel.font = [UIFont systemFontOfSize:16];
                cell.backgroundColor = [UIColor clearColor];
                cell.detailTextLabel.font = [UIFont systemFontOfSize:10];
                cell.selectionStyle = UITableViewCellSelectionStyleDefault;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }*/
            [(PercentChartView*)[cell viewWithTag:3] setPercent: group.percent.doubleValue];
            [(UILabel*)[cell viewWithTag:1] setText: group.name];
            [(UILabel*)[cell viewWithTag:2] setText:group.detail];
            // cell.imageView.image = theImage;
            return cell;
        }
        case 1: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Section2Cell"];
            if(cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Section2Cell"];
                cell.textLabel.font = [UIFont systemFontOfSize:16];
                cell.backgroundColor = [UIColor clearColor];
                cell.accessoryType = UITableViewCellAccessoryDetailButton;
            }
            switch(index) {
                case 0:
                    cell.textLabel.text = @"Vocabulary Quiz";
                    break;
                case 1:
                    cell.textLabel.text = @"Word of the Day";
                    break;
                default:
                    break;
            }
            return cell;
        }
        case 2: {
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
        default:
            return nil;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return self.vocabGroups.count;
        case 1:
            return 2;
        case 2:
            return 1;
        default:
            return 0;
    }
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
            switch (indexPath.row) {
                case 0: {// Quiz
                    UIViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"VocabQuizController"];
                    [self.navigationController pushViewController:vc animated:YES];
                    break;
                }
                case 1: // Word of the day;
                    break;
            }
            break;
        }
        case 2: {
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
    switch (section) {
        case 1:
            return @"Vocabulary Games";
        case 2:
            return @"More Vocabulary Sets";
        default:
            return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

@end
