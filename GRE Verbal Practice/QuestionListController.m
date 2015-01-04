//
//  QuestionListController.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/29/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "QuestionListController.h"
#import "QuestionSet.h"
#import "QuestionViewController.h"
#import "UIUtils.h"
#import "DataManager.h"

@interface QuestionListController ()

@end

@implementation QuestionListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIUtils backgroundColor];
    // self.clearsSelectionOnViewWillAppear = NO;
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = [indexPath row];
    
    QuestionSet* qs = [self.questionSets objectAtIndex:index];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DefaultCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"DefaultCell"];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = [UIColor clearColor];
    }
    [cell.textLabel setText: qs.name];
    [cell.detailTextLabel setText:qs.detail];
    // cell.imageView.image = theImage;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0)
        return self.questionSets.count;
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    QuestionSet* selected = (QuestionSet*)[self.questionSets objectAtIndex:indexPath.row];
    selected.lastVisited = [NSDate date];
    [[DataManager defaultManager] save];
    if([selected isEmpty]) {
        UIAlertController* messageBox =
        [UIAlertController alertControllerWithTitle:@"Empty QuestionSet"
                                            message:@"This is an empty QuestionSet"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okAction = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       [self dismissViewControllerAnimated:YES completion:nil];
                                   }];
        
        [messageBox addAction: okAction];
        [self presentViewController:messageBox animated:YES completion:nil];
    } else {
        QuestionViewController* qvc = (QuestionViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"QuestionViewController"];
        [qvc setQuestionSet:selected];
        [self showViewController:qvc sender:self];
    }
}

@end
