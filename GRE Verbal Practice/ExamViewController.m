//
//  ExamViewController.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/16/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "ExamViewController.h"
#import "DateUtils.h"
#import "UIUtils.h"

@interface ExamViewController ()

@end

@implementation ExamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIUtils backgroundColor];
    
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
    
    
    [menuView addButton:@"Quit" image:[UIImage imageNamed:@"General_Cancel"] target:self action:@selector(onQuit:)];
    menuView.externalDelegate = self;
    menuView.externalDataSource = self;
    
    if(!self.reviewMode) {
        [menuView addButton:@"Submit" image:[UIImage imageNamed:@"General_OK"] target:self action:@selector(showResult:)];
        

        UIBarButtonItem *bookmarkButton = [[UIBarButtonItem alloc] initWithTitle:@" "
                                                                           style:UIBarButtonItemStylePlain
                                                                          target:self
                                                                          action:@selector(markQuestion:)];
        bookmarkButton.image = [UIImage imageNamed:@"Bookmark"];
    
        timeButton = [[UIBarButtonItem alloc] initWithTitle:@" "
                                                      style:UIBarButtonItemStylePlain
                                                     target:self
                                                     action:@selector(toggleTime:event:)];
        timeButton.image = [UIImage imageNamed:@"Time"];
        item.rightBarButtonItems = @[bookmarkButton,timeButton];
    }
    
    id<AnswerListener> listener = self;
    if(self.reviewMode) {
        listener = nil;
    }
    
    sevc = (SEViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"SEViewController"];
    [sevc setAnswerListener:listener];
    tcvc = (TCViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"TCViewController"];
    [tcvc setAnswerListener:listener];
    rcvc = (RCViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"RCViewController"];
    [rcvc setAnswerListener:listener];
    
    msgvc = (MessageViewController*)[self.storyboard
        instantiateViewControllerWithIdentifier:@"MessageViewController"];
    
    
    // Instantiate Time Label
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
    self.timeLabel.textColor = [UIColor whiteColor];
    self.timeLabel.backgroundColor = [UIColor clearColor];
    self.timeLabel.font = [UIFont systemFontOfSize:14];
    self.timeLabel.hidden = YES;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleTime:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self.timeLabel addGestureRecognizer:tapGestureRecognizer];
    self.timeLabel.userInteractionEnabled = YES;
    [self.navigationController.navigationBar addSubview:self.timeLabel];
    
    // Check Exam Suite
    if([self.examSuite size] == 0) {
        [self showContentController:msgvc];
    }else {
        [self showQuestion: [self.examSuite question]];
        // Initialize Timer
        if(!self.reviewMode){
            timer = [[ExamTimer alloc] initWithMinutes:[self.examSuite timeLimit].integerValue
                                                target:self
                                              interval:@selector(timerInterval:)
                                                  done:@selector(showResultView)];
        }
    }
    
    self->markedQuestions = [[NSMutableSet alloc] init];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.timeLabel.hidden = YES;
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
    self.navigationItem.title = [NSString stringWithFormat:@"%zd/%zd",
                                 self.examSuite.current + 1,
                                 (long)self.examSuite.size];
    if(self.reviewMode) {
        [self->currentController showAnswerWithChoice:[self.examSuite currentAnswer]];
        [self->currentController showExplanation:YES];
    } else {
        [self->currentController showChoice: [self.examSuite currentAnswer]];
    }
}

- (void)timerInterval:(NSNumber*) r {
    long remain = [r longValue];
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        self.timeLabel.text = [DateUtils format:remain];
    }];

}

- (void)showResultView {
    
    [self->timer stop];
    self.examSuite.timeRemain = self->timer.remain;
    
    // Show result view and disable toolbar
    ExamResultController* ervc = (ExamResultController*)[self.storyboard instantiateViewControllerWithIdentifier:@"ExamResultController"];
    [ervc setExamSuite: self.examSuite];
    void (^updateUI)() = ^{
        UINavigationController* navController = self.navigationController;
        NSMutableArray *controllers=[[NSMutableArray alloc] initWithArray:navController.viewControllers] ;
        UIViewController* last = [controllers lastObject];
        [last willMoveToParentViewController:nil];
        [controllers removeLastObject];
        [navController setViewControllers:controllers];
        [last removeFromParentViewController];
        [last didMoveToParentViewController:nil];
        [navController pushViewController: ervc animated:YES];
    };

    if([NSThread isMainThread]) {
        updateUI();
    } else {
        [[NSOperationQueue mainQueue] addOperationWithBlock: updateUI];
    }
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
        UIAlertController* messageBox =
        [UIAlertController alertControllerWithTitle:@"The end"
                                            message:@"This is the last question. Do you want to submit?"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"Submit"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             [self dismissViewControllerAnimated:YES completion:nil];
                                                             [self showResult:nil];
                                                         }];
        [messageBox addAction:okAction];
        
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Continue"
                                                               style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction * action) {
                                                                 [self dismissViewControllerAnimated:YES completion:nil];
                                                            }];
        [messageBox addAction:cancelAction];
        
        [self presentViewController:messageBox animated:YES completion:nil];
    } else {
        [self showQuestion: [self.examSuite question]];
    }
}

- (void)prevQuestion:(id)button {
    if(![self.examSuite prev]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"The beginning"
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
    NSString* message = nil;
    if([self->markedQuestions containsObject: current]) {
        [markedQuestions removeObject:current];
        message = @"Question is unmarked";
    } else {
        [markedQuestions addObject:current];
        message = @"Question is marked";
    }
    UIAlertController* messageBox =
    [UIAlertController alertControllerWithTitle:message
                                        message:nil
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action) {
                                                         [self dismissViewControllerAnimated:YES completion:nil];
                                                     }];
    [messageBox addAction:okAction];
    [self presentViewController:messageBox animated:YES completion:nil];
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

// This is from Button
- (void)toggleTime:(id)sender event:(UIEvent *)event {
    if(self.timeLabel.frame.origin.x == 0) {
        CGRect buttonBounds = [[event.allTouches anyObject] view].frame;
        CGFloat width = self.timeLabel.frame.size.width;
        CGFloat height = self.timeLabel.frame.size.height;
        CGFloat centerx = buttonBounds.origin.x + buttonBounds.size.width/2;
        CGFloat centery = buttonBounds.origin.y + buttonBounds.size.height/2;
        self.timeLabel.frame = CGRectMake(centerx - width/2, centery - height/2, width, height);
    }
    self.timeLabel.hidden = NO;
    UIBarButtonItem* button = (UIBarButtonItem*)sender;
    NSMutableArray* buttons = [[NSMutableArray alloc]initWithArray:self.navigationItem.rightBarButtonItems];
    [buttons removeObject:button];
    self.navigationItem.rightBarButtonItems = buttons;
}

// This is from UILabel
- (void)toggleTime:(id)sender {
    self.timeLabel.hidden = YES;
    NSMutableArray* buttons = [[NSMutableArray alloc]initWithArray:self.navigationItem.rightBarButtonItems];
    [buttons addObject:timeButton];
    self.navigationItem.rightBarButtonItems = buttons;
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
    cell.textLabel.text = [NSString stringWithFormat:@"Question %zd", indexPath.row + 1];
    NSNumber* current = [NSNumber numberWithInteger:indexPath.row];
    UIImage* bookmarkImage = [[UIImage imageNamed:@"Bookmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    if([markedQuestions containsObject:current]) {
        cell.imageView.image = bookmarkImage;
    } else {
        cell.imageView.image = nil;
    }
    [cell setTintColor:[UIColor redColor]];
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
