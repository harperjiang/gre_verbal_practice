//
//  UpdateViewController.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/23/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpDownloadSupport.h"
#import "SSZipArchive.h"

@interface UpdateViewController : UIViewController<HttpDownloadListener,SSZipArchiveDelegate> {
    HttpDownloadSupport* _voiceDownloadSupport;
    HttpDownloadSupport* _dataDownloadSupport;
    HttpDownloadSupport* _versionDownloadSupport;
}

@property(nonatomic, readwrite, strong) IBOutlet UILabel* voiceVersionLabel;
@property(nonatomic, readwrite, strong) IBOutlet UIProgressView* voiceProgressView;
@property(nonatomic, readwrite, strong) IBOutlet UIButton* voiceButton;

@property(nonatomic, readwrite, strong) IBOutlet UILabel* dataVersionLabel;
@property(nonatomic, readwrite, strong) IBOutlet UIProgressView* dataProgressView;
@property(nonatomic, readwrite, strong) IBOutlet UIButton* dataButton;


@property(nonatomic) IBOutlet UITextView* labelText1;
@property(nonatomic) IBOutlet UITextView* labelText2;
@property(nonatomic) IBOutlet NSLayoutConstraint* labelHeight1;
@property(nonatomic) IBOutlet NSLayoutConstraint* labelHeight2;

- (IBAction)checkVoiceUpdate:(id)sender;
- (IBAction)checkDataUpdate:(id)sender;

@end
