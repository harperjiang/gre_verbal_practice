//
//  VocabViewController.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/16/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import <AVFoundation/AVFoundation.h>
#import "VocabPlan.h"
#import "AdBannerSupport.h"

@interface VocabViewController : UIViewController<AVAudioPlayerDelegate> {
    AVAudioPlayer* _player;
    ADBannerView* _bannerView;
}

@property(nonatomic, readwrite, strong) AdBannerSupport* adSupport;

@property(nonatomic, readwrite, strong) IBOutlet UILabel* progressLabel;
@property(nonatomic, readwrite, strong) IBOutlet UILabel* messageLabel;

@property(nonatomic, readwrite, strong) IBOutlet UIButton* playButton;

@property(nonatomic, readwrite, strong) IBOutlet UILabel* wordLabel;
@property(nonatomic, readwrite, strong) IBOutlet UILabel* explanationLabel;
@property(nonatomic, readwrite, strong) IBOutlet UILabel* synonymLabel;
@property(nonatomic, readwrite, strong) IBOutlet UILabel* sampleLabel;

@property(nonatomic, readwrite, strong) IBOutlet UIButton* knowButton;
@property(nonatomic, readwrite, strong) IBOutlet UIButton* dontknowButton;
@property(nonatomic, readwrite, strong) IBOutlet UIButton* showButton;

@property(nonatomic, readwrite, strong) VocabPlan* plan;
@property(nonatomic, readwrite, strong) Vocabulary* currentVocab;

- (IBAction)buttonPressed:(id) button;
- (IBAction)playSound:(id)button;
@end
