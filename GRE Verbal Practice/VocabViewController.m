//
//  VocabViewController.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/16/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "VocabViewController.h"
#import "Vocabulary.h"
#import "DataManager.h"

@interface VocabViewController ()

@end

@implementation VocabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Ad Banner Setup
    self.bannerSupport = [[AdBannerSupport alloc] init];
    [self.bannerSupport setBannerView: self.adBannerView];
    [self.bannerSupport setBottomConstraint: self.adBannerBtmCon];

    // VocabPlan setup
    if(self.plan == nil) {
        [self modeMessage:@"No data found!"];
    } else {
        [self showVocab: [self.plan nextVocab] status:[self.plan status]];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)showVocab:(Vocabulary*)data status:(NSString*) status{
    self.currentVocab = data;
    [self.wordLabel setText:data.word];
    [self.explanationLabel setText: data.explanation];
    [self.synonymLabel setText: data.synonyms];
    [self.sampleLabel setText:data.samples];
    [self.progressLabel setText: status];
}

- (void)buttonPressed:(id) button {
    if(button == self.showButton) {
        [self modeAnswer];
    }
    
    if(button == self.knowButton || button == self.dontknowButton) {
        [self.plan feedback:(button == self.knowButton)];
        
        Vocabulary* vocab = [self.plan nextVocab];
        if(vocab == nil) {
            // No more vocabulary
            self.currentVocab = nil;
            [self modeMessage:@"Today's plan is done"];
        } else {
            [self modeQuestion];
            [self showVocab: [self.plan nextVocab] status:[self.plan status]];
        }
        
        // Persist the state of plan
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
            [[DataManager defaultManager] updateVocabProgress: self.currentVocab];
        });
    }
}

- (void)modeQuestion {
    [self.explanationLabel setHidden:true];
    [self.knowButton setHidden:true];
    [self.dontknowButton setHidden:true];
    [self.showButton setHidden:false];
}

- (void)modeAnswer {
    [self.explanationLabel setHidden:false];
    [self.knowButton setHidden:false];
    [self.dontknowButton setHidden:false];
    [self.showButton setHidden:true];
}

- (void)modeMessage:(NSString*)message {
    [self.wordLabel setHidden:YES];
    [self.playButton setHidden:YES];
    [self.synonymLabel setHidden:YES];
    [self.sampleLabel setHidden:YES];
    [self.explanationLabel setHidden:YES];
    [self.knowButton setHidden:YES];
    [self.dontknowButton setHidden:YES];
    [self.showButton setHidden:YES];
    [self.progressLabel setHidden:YES];
    [self.messageLabel setHidden:NO];
    [self.messageLabel setText:message];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    NSLog(@"Encoding...");
}

@end
