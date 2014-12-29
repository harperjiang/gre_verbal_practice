//
//  ExamViewController.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/16/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "ExamViewController.h"

@interface ExamViewController ()

@end

@implementation ExamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UINavigationItem* item = self.navigationItem;
    item.title = self.examSuite.name;
    
    
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithTitle:@" "
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(showMenu:event:)];
    menuButton.image = [UIImage imageNamed:@"Menu"];
    item.hidesBackButton = YES;
    item.leftBarButtonItem = menuButton;
    
    menuView = [[MenuView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    menuView.mainView = self.navigationController.view;
    
    
    [menuView addButton:@"Quit" image:nil target:self action:@selector(onQuit:)];
    menuView.externalDelegate = self;
    menuView.externalDataSource = self;
    
    if(!self.reviewMode) {
        [menuView addButton:@"Submit" image:nil target:self action:@selector(showResult:)];
        

        UIBarButtonItem *bookmarkButton = [[UIBarButtonItem alloc] initWithTitle:@" "
                                                                           style:UIBarButtonItemStylePlain
                                                                          target:self
                                                                          action:@selector(markQuestion:)];
        bookmarkButton.image = [UIImage imageNamed:@"Bookmark"];
    
        UIBarButtonItem *timeButton = [[UIBarButtonItem alloc] initWithTitle:@" "
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(toggleTime:event:)];
        timeButton.image = [UIImage imageNamed:@"Time"];
        item.rightBarButtonItems = @[bookmarkButton,timeButton];
    }
    
    sevc = (SEViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"SEViewController"];
    tcvc = (TCViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"TCViewController"];
    rcvc = (RCViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"RCViewController"];
    msgvc = (MessageViewController*)[self.storyboard
        instantiateViewControllerWithIdentifier:@"MessageViewController"];
    
    // Instantiate Time Label
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
    self.timeLabel.textColor = [UIColor whiteColor];
    self.timeLabel.backgroundColor = [UIColor clearColor];
    self.timeLabel.font = [UIFont systemFontOfSize:14];
    self.timeLabel.hidden = YES;
    [self.navigationController.navigationBar addSubview:self.timeLabel];
    
    // Check Exam Suite
    if([self.examSuite size] == 0) {
        [self showContentController:msgvc];
    }else {
        [self showQuestion: [self.examSuite question]];
        // Initialize Timer
        if(!self.reviewMode){
            timer = [[ExamTimer alloc] initWithMinutes:[self.examSuite timeLimit]
                                                target:self
                                              interval:@selector(timerInterval:)
                                                  done:@selector(showResultView)];
        }
    }
    
    self->markedQuestions = [[NSMutableSet alloc] init];
}

- (void)showQuestion:(Question*) question {
    if(question == nil) {
        NSLog(@"Error, empty question shown");
        return;
    }
    switch([question type]) {
        case READING_COMP:
            [self showContentController: (UIViewController*)rcvc];
            break;
        case TEXT_COMPLETION:
            [self showContentController: tcvc];
            break;
        case SENTENCE_EQUIV:
            [self showContentController: sevc];
            break;
        default:
            break;
    }
    [self->currentController setQuestionData:question];
    self.navigationItem.title = [NSString stringWithFormat:@"%ld/%ld",
                                 self.examSuite.current + 1,
                                 self.examSuite.size];
    if(self.reviewMode) {
        [self->currentController showChoice:[self.examSuite currentAnswer]];
        [self->currentController showAnswer];
        [self->currentController showExplanation];
    }
}

- (void)timerInterval:(NSNumber*) r {
    long remain = [r longValue];
    long hour = remain / 3600;
    remain = remain % 3600;
    long minute = remain / 60;
    long second = remain % 60;
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        self.timeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld", hour, minute, second];
    }];
}

- (void)showResultView {
    // Send Result Information to Result view
    // TODO
    // Show result view and disable toolbar
    ExamResultController* ervc = (ExamResultController*)[self.storyboard instantiateViewControllerWithIdentifier:@"ExamResultController"];
    [ervc setExamSuite: self.examSuite];
    void (^updateUI)() = ^{
        UINavigationController* navController = self.navigationController;
        NSMutableArray *controllers=[[NSMutableArray alloc] initWithArray:navController.viewControllers] ;
        [controllers removeLastObject];
        [navController setViewControllers:controllers];
        [navController pushViewController: ervc animated:YES];
    };

    if([NSThread isMainThread]) {
        updateUI();
    } else {
        [[NSOperationQueue mainQueue] addOperationWithBlock: updateUI];
    }
    [self->timer stop];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)automaticallyAdjustsScrollViewInsets {
    return NO;
}

- (void)hideContentController:(UIViewController*) vc {
    [vc willMoveToParentViewController:nil];  // 1
    [vc.view removeFromSuperview];            // 2
    [vc removeFromParentViewController];      // 3
    [(id<QViewController>)vc setAnswerListener: nil];
}

- (void)showContentController:(UIViewController*) vc {
    if(currentController != (id<QViewController>)vc) {
        if(currentController != nil) {
            [self hideContentController: (UIViewController*)currentController];
        }
        [self addChildViewController:vc];
        vc.view.frame = self.containerView.frame;
        [self.containerView addSubview: vc.view];
        [vc didMoveToParentViewController:self];
        currentController = (id<QViewController>)vc;
        [(id<QViewController>)currentController setAnswerListener: self];
    }
}

- (IBAction)swipe:(UISwipeGestureRecognizer *)recognizer {
    if(recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        [self nextQuestion:recognizer];
    }
    if(recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        [self prevQuestion:recognizer];
    }
}

- (void)nextQuestion:(id)button {
    if(![self.examSuite next]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"The end"
                                                        message:@"This is the last question!"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    [self showQuestion: [self.examSuite question]];
}

- (void)prevQuestion:(id)button {
    if(![self.examSuite prev]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No more"
                                                        message:@"This is the first question!"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    [self showQuestion: [self.examSuite question]];
}

- (void)markQuestion:(id)button {
    NSNumber* current = [NSNumber numberWithInteger:self.examSuite.current];
    if([self->markedQuestions containsObject: current]) {
        [markedQuestions removeObject:current];
    } else {
        [markedQuestions addObject:current];
    }
    [self->menuView reloadData];
}

- (void)showResult:(id)button {
    [self showResultView];
}

- (void)answerChanged:(NSArray *)answer {
    [self.examSuite answer:answer for: self.examSuite.current];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)showMenu:(id)sender event:(UIEvent *)event{
    [self->menuView toggleMenu:sender event:event];
}

- (void)toggleTime:(id)sender event:(UIEvent *)event {
    CGRect buttonBounds = [[event.allTouches anyObject] view].frame;
    CGFloat width = 60;
    CGFloat height = 20;
    CGFloat centerx = buttonBounds.origin.x + buttonBounds.size.width/2;
    CGFloat centery = buttonBounds.origin.y + buttonBounds.size.height/2;
    self.timeLabel.frame = CGRectMake(centerx - width/2, centery - height/2, width, height);
    self.timeLabel.hidden = !self.timeLabel.hidden;
    UIBarButtonItem* button = (UIBarButtonItem*)sender;
    [button setImage:self.timeLabel.hidden? [UIImage imageNamed:@"Time"]:nil];
}

- (void)onQuit:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TableView Datas

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if(section == 1) {
        return self.examSuite.size;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuestionCell"];
    if(nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"QuestionCell"];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"Question %ld", indexPath.row + 1];
    NSNumber* current = [NSNumber numberWithInteger:indexPath.row];
    if([markedQuestions containsObject:current]) {
        cell.imageView.image = [UIImage imageNamed:@"Bookmark"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Goto a question
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self->menuView toggleMenu:nil event:nil];
    [self.examSuite setCurrent: indexPath.row];
    [self showQuestion: [self.examSuite.questions objectAtIndex:indexPath.row]];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(section == 1)
        return @"Questions";
    return nil;
}

@end
