//
//  ExamPrepViewController.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/27/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "ExamPrepController.h"
#import "ExamViewController.h"
#import "ExamSuite.h"
#import "UIUtils.h"
#import "DataManager.h"
#import "UIUtils.h"

@interface ExamPrepController ()

@end

@implementation ExamPrepController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.examTableView.backgroundColor = [UIUtils backgroundColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.examTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch(indexPath.section) {
        case 0: {
            NSInteger index = [indexPath row];
            
            ExamSuite* suite = [self.examSuites objectAtIndex:index];
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DefaultCell"];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"DefaultCell"];
                cell.textLabel.font = [UIFont systemFontOfSize:16];
                cell.detailTextLabel.font = [UIFont systemFontOfSize:10];
                cell.selectionStyle = UITableViewCellSelectionStyleDefault;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.backgroundColor = [UIColor clearColor];
            }
            [cell.textLabel setText: suite.name];
            [cell.detailTextLabel setText: [@"" isEqualToString:suite.statistics]? suite.difficultyString: suite.statistics];
            // cell.imageView.image = theImage;
            return cell;
        }
        case 1: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Section2Cell"];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"FixedCell"];
                cell.textLabel.font = [UIFont systemFontOfSize:16];
                cell.detailTextLabel.font = [UIFont systemFontOfSize:10];
                cell.selectionStyle = UITableViewCellSelectionStyleDefault;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.backgroundColor = [UIColor clearColor];
            }
            switch(indexPath.row) {
                case 0:
                    [cell.textLabel setText: @"Easy"];
                    break;
                case 1:
                    [cell.textLabel setText: @"Normal"];
                    break;
                case 2:
                    [cell.textLabel setText: @"Hard"];
                    break;

                default:
                    break;
            }
            // cell.imageView.image = theImage;
            return cell;
        }
        case 2: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FixedCell"];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"FixedCell"];
                cell.textLabel.font = [UIFont systemFontOfSize:16];
                cell.detailTextLabel.font = [UIFont systemFontOfSize:10];
                cell.selectionStyle = UITableViewCellSelectionStyleDefault;
                cell.accessoryType = UITableViewCellAccessoryDetailButton;
                cell.backgroundColor = [UIColor clearColor];
            }
            switch(indexPath.row) {
                case 0:
                    [cell.textLabel setText: @"Visit Update Site"];
                    break;
                default:
                    break;
            }
            // cell.imageView.image = theImage;
            return cell;
        }
        default:
            return nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return self.examSuites.count;
        case 1:
            return 3;
        case 2:
            return 1;
        default:
            break;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

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

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 1:
            return @"Random Exam Suite";
        case 2:
            return @"More Exam Suites";
        default:
            return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.section) {
        case 0:{
            ExamViewController* evc = (ExamViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"ExamViewController"];
            ExamSuite* selectedSuite = (ExamSuite*)[self.examSuites objectAtIndex:indexPath.row];
            // Clear all transient information
            [selectedSuite reset];
            [selectedSuite setLastVisited:[NSDate date]];
            [[DataManager defaultManager] save];
            [evc setExamSuite:selectedSuite];
            
            [self showViewController:evc sender:nil];
            break;
        }
        case 1: {
            // TODO Create Random Exam Suite
            NSInteger diffculty = 2 - indexPath.row;
            ExamSuite* tempSuite = [ExamSuite create:diffculty];
            
            if([tempSuite size] == 0) { // Empty
                UIAlertController* messageBox =
                [UIAlertController alertControllerWithTitle:@"Not enough data"
                                                    message:@"There's not enough questions in the selected level. You can visit update site to download more question sets."
                                             preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"OK"
                                                                   style:UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction * action) {
                                                                     [self dismissViewControllerAnimated:YES completion:nil];
                                                                 }];
                [messageBox addAction:okAction];
                [self presentViewController:messageBox animated:YES completion:nil];
            } else {
                ExamViewController* evc = (ExamViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"ExamViewController"];
                [evc setExamSuite:tempSuite];
                [self showViewController:evc sender:nil];
            }
            break;
        }
        case 2:{
            switch(indexPath.row) {
                case 0: {
                    UIViewController* updateController = [self.storyboard instantiateViewControllerWithIdentifier:@"UpdateViewController"];
                    [self.navigationController pushViewController:updateController animated:YES];
                    break;
                }
            }
            break;
        }
    }
}


@end
