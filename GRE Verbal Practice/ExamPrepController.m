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

@interface ExamPrepController ()

@end

@implementation ExamPrepController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = [indexPath row];
    
    ExamSuite* suite = [self.examSuites objectAtIndex:index];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DefaultCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"DefaultCell"];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:10];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    [cell.textLabel setText: suite.name];
    [cell.detailTextLabel setText:suite.statistics];
    // cell.imageView.image = theImage;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0)
        return self.examSuites.count;
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    ExamViewController* evc = (ExamViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"ExamViewController"];
    ExamSuite* selectedSuite = (ExamSuite*)[self.examSuites objectAtIndex:indexPath.row];
    [evc setExamSuite:selectedSuite];
    
    [self showViewController:evc sender:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end