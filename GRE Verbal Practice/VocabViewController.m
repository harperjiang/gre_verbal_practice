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
#import "UIUtils.h"
#import "HttpDownloadSupport.h"

@interface VocabViewController ()

@end

@implementation VocabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIUtils backgroundColor];
    
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
    [self.adSupport setBottomConstraint: self.bottomHeight];
    
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

- (void)viewWillLayoutSubviews {
    CGRect bound = self.view.bounds;
    self.pageWidth.constant = bound.size.width;
}

- (void)viewDidLayoutSubviews {
    CGRect bounds = self.explanationText.bounds;
    CGSize expect = [self.explanationText sizeThatFits:CGSizeMake(bounds.size.width, 10000)];
    self.explainHeight.constant = expect.height;
    
    bounds = self.sampleText.bounds;
    expect = [self.sampleText sizeThatFits:CGSizeMake(bounds.size.width, 10000)];
    self.sampleHeight.constant = expect.height;
    
    bounds = self.synonymText.bounds;
    expect = [self.synonymText sizeThatFits:CGSizeMake(bounds.size.width, 10000)];
    self.synonymHeight.constant = expect.height;
    
    
    [self.adSupport layoutAnimated:NO];
}

- (void)showVocab:(Vocabulary*)data status:(NSString*) status{
    self.currentVocab = data;
    [self.wordLabel setText:data.word];
    [self.explanationText setText: data.explanation];
    [self.synonymText setText: data.synonyms];
    [self.sampleText setText:data.samples];
    [self.progressLabel setText: status];
    
    // Play sound if corresponding file exists
    [self playSound: nil];
}

- (void)buttonPressed:(id) button {
    if(button == self.showButton) {
        [self modeAnswer];
    }
    
    if(button == self.knowButton || button == self.dontknowButton) {
        BOOL know = (button == self.knowButton);
        [self.plan feedback: know];
        Vocabulary* vocab = [self.plan nextVocab];
        
        if(vocab == nil) {
            // No more vocabulary
            // TODO Why do I need this?
            // self.currentVocab = nil;
            [self modeMessage:@"Today's plan is done"];
        } else {
            [self modeQuestion];
            [self showVocab: vocab status:[self.plan status]];
        }
    }
}

- (void)playSound:(id)button {
    // Determine Sound File URL based on word name;
    NSURL* soundFileUrl = [FileManager voiceFileFor:self.currentVocab.word check:YES];
    if(soundFileUrl == nil) {
        [self downloadVoiceFile:self.currentVocab.word];
        return;
    }
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
        // Disable Alert for no-audio file
        if(button == nil)
            return;
        // Only play error message when user click the button
        UIAlertController* messageBox =
        [UIAlertController alertControllerWithTitle:@"Voice File not found"
                                            message:@"Please connect to Internet or upgrade to latest voice package."
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okAction = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       [self dismissViewControllerAnimated:YES completion:nil];
                                   }];
        
        [messageBox addAction: okAction];
        [self presentViewController:messageBox animated:YES completion:nil];
    }
}

- (void)modeQuestion {
    [self.explanationText setHidden:true];
    [self.knowButton setHidden:true];
    [self.dontknowButton setHidden:true];
    [self.showButton setHidden:false];
}

- (void)modeAnswer {
    [self.explanationText setHidden:false];
    [self.knowButton setHidden:false];
    [self.dontknowButton setHidden:false];
    [self.showButton setHidden:true];
}

- (void)modeMessage:(NSString*)message {
    [self.wordLabel setHidden:YES];
    [self.playButton setHidden:YES];
    [self.synonymText setHidden:YES];
    [self.sampleText setHidden:YES];
    [self.explanationText setHidden:YES];
    [self.knowButton setHidden:YES];
    [self.dontknowButton setHidden:YES];
    [self.showButton setHidden:YES];
    [self.progressLabel setHidden:YES];
    [self.messageLabel setHidden:NO];
    [self.messageLabel setText:message];
    
    [UIView animateWithDuration:5 delay: 3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [self.navigationController popViewControllerAnimated:YES];
    } completion:nil];
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

#pragma mark - Http Download Listener

- (void) downloadVoiceFile:(NSString*)word {
    self.playButton.hidden = YES;
    self.actIndicator.hidden = NO;
    [self.actIndicator startAnimating];
    
    NSLog(@"Downloading voice file from Google");
    NSString* urlbase = @"https://ssl.gstatic.com/dictionary/static/sounds/de/0/%@.mp3";
    NSString* url = [NSString stringWithFormat:urlbase, word];
    HttpDownloadSupport* download = [[HttpDownloadSupport alloc] init:NO];
    download.targetURL = url;
    download.destinationFile = [FileManager voiceFileFor:word check:NO];
    download.listener = self;
    [download download];
}

- (void)onProgress:(HttpDownloadSupport *)source progress:(float)progress {
    // Nothing to do
}

- (void)onSuccess:(HttpDownloadSupport *)source {
    self.playButton.hidden = NO;
    [self.actIndicator stopAnimating];
    // Make sure the file exists
    [self playSound:nil];
}

- (void)onError:(HttpDownloadSupport *)source error:(NSError *)error {
    self.playButton.hidden = NO;
    [self.actIndicator stopAnimating];
    
    NSLog(@"No sound file found for %@",self.currentVocab.word);
    /*
    // Only play error message when user click the button
    UIAlertController* messageBox =
    [UIAlertController alertControllerWithTitle:@"Voice File not found"
                                        message:@"Please connect to Internet or upgrade to latest voice package."
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okAction = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   [self dismissViewControllerAnimated:YES completion:nil];
                               }];
    
    [messageBox addAction: okAction];
    [self presentViewController:messageBox animated:YES completion:nil];
     */
}

@end
