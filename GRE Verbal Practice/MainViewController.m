//
//  MainViewController.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/9/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "MainViewController.h"
#import "QuestionListController.h"
#import "ExamPrepController.h"
#import "VocabGroupController.h"
#import "DataManager.h"
#import "UserPreference.h"
#import "DataImporter.h"
#import "SEViewController.h"
#import "UIBlockView.h"
#import "UIUtils.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (BOOL)isPad {
#ifdef UI_USER_INTERFACE_IDIOM
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
#else
    return NO;
#endif
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIUtils backgroundColor];
    
    self.adSupport = [[AdBannerSupport alloc] init];
    // On iOS 6 ADBannerView introduces a new initializer, use it when available.
    if ([ADBannerView instancesRespondToSelector:@selector(initWithAdType:)]) {
        _bannerView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
    } else {
        _bannerView = [[ADBannerView alloc] init];
    }
    
    [self.adSupport setBannerView: _bannerView];
    [self.view addSubview:_bannerView];
    
    [self.adSupport setParentView: self.view];
    [self.adSupport setShrinkView: self.scrollView];
    [self.adSupport setBottomConstraint: self.bottomConstraint];
    
    // Add Button to NavigationBar
    UIBarButtonItem* infoButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Info"] style:UIBarButtonItemStylePlain target:self action:@selector(showAboutInfo:)];
    self.navigationItem.rightBarButtonItem = infoButton;
    
    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"Main"
                                      style:UIBarButtonItemStylePlain
                                     target:nil
                                     action:nil];
    
    // Add Buttons to Block View
    if([self isPad]) {
        self.blockView.hMargin = 60;
        self.blockView.vMargin = 40;
        self.blockView.vInset = 40;
        self.blockView.hInset = 60;
        self.blockView.columns = 5;
        self.blockView.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    } else {
        self.blockView.hMargin = 40;
        self.blockView.vMargin = 40;
        self.blockView.vInset = 20;
        self.blockView.hInset = 50;
        self.blockView.columns = 3;
        self.blockView.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    }
    self.blockView.ownerView = self.view;
    [self.blockView addItem:@"Vocabulary"
                      image:[UIImage imageNamed:@"Main_Vocab"]
                     target:self
                     method:@selector(showVocabController:)
                      param:nil];
    
    [self.blockView addItem:@"Text\nCompletion"
                      image:[UIImage imageNamed:@"Main_TC"]
                     target:self
                     method:@selector(pushQuestionController:param:)
                      param:@"Text Completion"];
    
    [self.blockView addItem:@"Reading\nComprehension"
                      image:[UIImage imageNamed:@"Main_RC"]
                     target:self
                     method:@selector(pushQuestionController:param:)
                      param:@"Reading Comprehension"];
    
    [self.blockView addItem:@"Sentence\nEquivalance"
                      image:[UIImage imageNamed:@"Main_SE"]
                     target:self
                     method:@selector(pushQuestionController:param:)
                      param:@"Sentence Equivalence"];
    
    [self.blockView addItem:@"Exam\nPractice"
                      image:[UIImage imageNamed:@"Main_Exam"]
                     target:self
                     method:@selector(showExamViewController:)
                      param:nil];
    
    [self.blockView addItem:@"Setting"
                      image:[UIImage imageNamed:@"Main_Setting"]
                     target:self
                     method:@selector(pushViewController:target:)
                      param:@"SettingViewController"];
    
    [self.blockView addItem:@"Update"
                      image:[UIImage imageNamed:@"Main_Update"]
                     target:self
                     method:@selector(pushViewController:target:)
                      param:@"UpdateViewController"];
    
    /*[self.blockView addItem:@"Import\nData"
                      image:nil
                     target:self
                     method:@selector(importData:)
                      param:nil];*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    if(![self isPad]) {
        NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
        [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
    }
}

- (void)viewDidLayoutSubviews {
    self.widthConstraint.constant = self.blockView.expected.width;
    self.heightConstraint.constant = self.blockView.expected.height;
    [self.adSupport layoutAnimated:NO];
}


- (NSUInteger)supportedInterfaceOrientations {
    if(![self isPad]) {
        return UIInterfaceOrientationMaskPortrait;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
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

#pragma mark - Import Data
- (IBAction)importData:(id)sender {
//    [DataImporter importTestData];
    [DataImporter importTestData];
}

- (void)pushViewController:(id)sender target:(NSString*)target {
    UIViewController* aboutvc = [self.storyboard instantiateViewControllerWithIdentifier:target];
    [self showViewController:aboutvc sender:sender];
}

- (void)pushQuestionController:(id)sender param:(NSString*)param {
    QuestionListController* qlc = (QuestionListController*)[self.storyboard instantiateViewControllerWithIdentifier:@"QuestionListController"];
    // Load Question List
    // Determine the question type
    QuestionType qt = READING_COMP;
    if ([@"Reading Comprehension" isEqualToString: param]) {
        qt = READING_COMP;
    }
    if ([@"Sentence Equivalence" isEqualToString: param]) {
        qt = SENTENCE_EQUIV;
    }
    if ([@"Text Completion" isEqualToString: param]) {
        qt = TEXT_COMPLETION;
    }
    qlc.questionType = qt;
    qlc.questionSets = [[DataManager defaultManager] getQuestionSets:qt];
    [self showViewController:qlc sender:sender];
}

- (void)showExamViewController:(id)sender {
    ExamPrepController* epvc = (ExamPrepController*)[self.storyboard instantiateViewControllerWithIdentifier:@"ExamPrepController"];
    
    epvc.examSuites = [[DataManager defaultManager] getExamSuites];
    [self showViewController:epvc sender: sender];
}

- (void)showVocabController:(id)sender {
    VocabGroupController* vgc = (VocabGroupController*)[self.storyboard instantiateViewControllerWithIdentifier:@"VocabGroupController"];
    vgc.vocabGroups = [[DataManager defaultManager] getVocabGroups];
    [self showViewController:vgc sender: sender];
}

- (void)showAboutInfo:(id) sender {
    UIViewController* aboutvc = [self.storyboard instantiateViewControllerWithIdentifier:@"AboutViewController"];
    [UIView transitionWithView:self.navigationController.view
                      duration:0.75
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        [self showViewController:aboutvc sender:sender];
                    }
                    completion:nil];
}

@end
