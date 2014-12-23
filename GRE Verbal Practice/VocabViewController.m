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
#import "FileManager.h"

@interface VocabViewController ()

@end

@implementation VocabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Ad Banner Setup
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
    [self.adSupport setShrinkView: nil];
    [self.adSupport setBottomConstraint: nil];


    // VocabPlan setup
    if(self.plan == nil) {
        [self modeMessage:@"No study plan installed."];
    } else if([self.plan doneWithSet]){
        [self modeMessage:@"You are done with the vocabulary study."];
    } else if([self.plan doneWithToday]) {
        [self modeMessage:@"You are done with today's plan."];
    } else {
        [self showVocab: [self.plan nextVocab] status:[self.plan status]];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidLayoutSubviews {
    [self.adSupport layoutAnimated:YES];
}

- (void)showVocab:(Vocabulary*)data status:(NSString*) status{
    self.currentVocab = data;
    [self.wordLabel setText:data.word];
    [self.explanationLabel setText: data.explanation];
    [self.synonymLabel setText: data.synonyms];
    [self.sampleLabel setText:data.samples];
    [self.progressLabel setText: status];
    
    // Play sound if corresponding file exists
    [self playSound: nil];
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

- (void)playSound:(id)button {
    // Determine Sound File URL based on word name;
    NSURL* soundFileUrl = [FileManager voiceFileFor:self.currentVocab.word];
    if(soundFileUrl != nil) {
        NSError* error;
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileUrl error: &error];
        if(nil == _player) {
            // Log the problem
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        } else {
            [_player prepareToPlay];
            [_player setDelegate:self];
            [_player play];
        }
    } else {
        NSLog(@"No sound file found for %@",self.currentVocab.word);
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

#pragma mark - AV Audio Player Delegate

- (void)audioPlayerDidFinishPlaying: (AVAudioPlayer *) player
                       successfully: (BOOL) completed {
    
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player
                                 error:(NSError *)error {
    NSLog(@"Error playback:%@,%@",error, [error userInfo]);
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
