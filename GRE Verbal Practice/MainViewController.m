//
//  MainViewController.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/9/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "MainViewController.h"
#import "QuestionViewController.h"
#import "ExamViewController.h"
#import "VocabViewController.h"
#import "DataManager.h"
#import "UserPreference.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.adSupport = [[AdBannerSupport alloc] init];
    [self.adSupport setBannerView:self.adBannerView];
    [self.adSupport setBottomConstraint: self.adBannerBottomCon];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)setup {
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self setup];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self) {
        [self setup];
    }
    return self;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([[segue destinationViewController] isKindOfClass:[QuestionViewController class]]) {
        QuestionViewController* qvc = (QuestionViewController*)
            [segue destinationViewController];
        // Load Question List
        // Determine the question type
        UIButton* btn = (UIButton*)sender;
        QuestionType qt = READING_COMP;
        if ([@"Reading Comprehension" isEqualToString: btn.titleLabel.text]) {
            qt = READING_COMP;
        }
        if ([@"Sentence Equivalance" isEqualToString: btn.titleLabel.text]) {
            qt = SENTENCE_EQUIV;
        }
        if ([@"Text Completion" isEqualToString: btn.titleLabel.text]) {
            qt = TEXT_COMPLETION;
        }
        
        [qvc setQuestionSet: [QuestionSet create:qt]];
    }
    if([[segue destinationViewController] isKindOfClass:[ExamViewController class]]) {
        // Load Exam Question List
        ExamViewController* evc = (ExamViewController*)[segue destinationViewController];
        [evc setExamSuite:[ExamSuite create]];
    }
    if([[segue destinationViewController] isKindOfClass:[VocabViewController class]]) {
        // Load Vocabulary List
        VocabViewController* vvc = (VocabViewController*)segue.destinationViewController;
        vvc.plan = [VocabPlan create];
    }
}

@end
