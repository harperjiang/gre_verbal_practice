//
//  UpdateViewController.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/23/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "UpdateViewController.h"
#import "UserPreference.h"
#import "DataImporter.h"
#import "FileManager.h"
#import "SSZipArchive.h"
#import "ZipSupport.h"
#import "UIUtils.h"

@interface UpdateViewController ()

@end

@implementation UpdateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIUtils backgroundColor];
    // Do any additional setup after loading the view.
    
    [self.voiceProgressView setHidden:YES];
    [self.dataProgressView setHidden:YES];
    
    NSInteger voiceVersion = [UserPreference getInteger:SYS_VOICE_VERSION defval:SYS_VOICE_VERSION_DEFAULT];
    [self.voiceVersionLabel setText: [NSString stringWithFormat:@"%zd", voiceVersion]];
    
    
    NSInteger dataVersion = [UserPreference getInteger:SYS_DATA_VERSION defval:SYS_DATA_VERSION_DEFAULT];
    [self.dataVersionLabel setText: [NSString stringWithFormat:@"%zd", dataVersion]];
    
    _dataDownloadSupport = [[HttpDownloadSupport alloc] init:YES];
    _dataDownloadSupport.listener = self;
    _dataDownloadSupport.targetURL = [UserPreference getString:SYS_UPDATE_URL
                                                        defval:SYS_UPDATE_URL_DEFAULT];
    
    
    _voiceDownloadSupport = [[HttpDownloadSupport alloc] init:NO];
    _voiceDownloadSupport.listener = self;
    _voiceDownloadSupport.targetURL = [UserPreference getString:SYS_VOICE_URL
                                                         defval:SYS_VOICE_URL_DEFAULT];
    _voiceDownloadSupport.destinationFile = [[FileManager appCacheDir] URLByAppendingPathComponent:@"voice.zip"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    CGSize size = self.labelText1.bounds.size;
    size = [self.labelText1 sizeThatFits: CGSizeMake(size.width, 10000)];
    self.labelHeight1.constant = size.height;
    
    size = self.labelText2.bounds.size;
    size = [self.labelText2 sizeThatFits: CGSizeMake(size.width, 10000)];
    self.labelHeight2.constant = size.height;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)updateUI:(void (^)(void))block {
    if([NSThread isMainThread]) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            block();
        });
    }
}

- (IBAction)checkDataUpdate:(id)sender {
    [self.dataButton setHidden:YES];
    [self.dataProgressView setProgress:0];
    [self.dataProgressView setHidden:NO];
    NSInteger currentVer = [UserPreference getInteger:SYS_DATA_VERSION defval:SYS_DATA_VERSION_DEFAULT];
    [self checkVersion:@"data" current:currentVer];
}

- (IBAction)checkVoiceUpdate:(id)sender {
    [self.voiceButton setHidden:YES];
    [self.voiceProgressView setProgress:0];
    [self.voiceProgressView setHidden:NO];
    NSInteger currentVer = [UserPreference getInteger:SYS_VOICE_VERSION defval:SYS_VOICE_VERSION_DEFAULT];
    [self checkVersion:@"voice" current:currentVer];
}

- (void)checkVersion:(NSString*)key current:(NSInteger)currentVer {
    
    [self.voiceButton setEnabled:NO];
    [self.dataButton setEnabled:NO];
    
    _versionDownloadSupport = [[HttpDownloadSupport alloc] init:YES];
    _versionDownloadSupport.targetURL = [UserPreference getString:SYS_VERSION_URL defval:SYS_VERSION_URL_DEFAULT];
    _versionDownloadSupport.listener = self;
    [_versionDownloadSupport.userinfo setObject:key forKey:@"type"];
    [_versionDownloadSupport.userinfo setObject:[NSNumber numberWithInteger:currentVer] forKey:@"current"];
    [_versionDownloadSupport download];
}

- (void)onError:(HttpDownloadSupport*)source error:(NSError*)error {
    NSLog(@"%@-%@", error, [error userInfo]);
    [self updateUI:^{
        [self showMessage:NO];
        [self updateDoneRefreshUI: source];
    }];
}

- (void)onSuccess:(HttpDownloadSupport*)source {
    if(source == _versionDownloadSupport) {
        NSString* type = [source.userinfo objectForKey:@"type"];
        NSInteger val = [(NSNumber*)[source.userinfo objectForKey:@"current"] integerValue];
        // Parse source data
        NSError* error = nil;
        NSDictionary* parsedJson = [NSJSONSerialization JSONObjectWithData:_versionDownloadSupport.destinationData
                                                                   options:NSJSONReadingMutableContainers
                                                                     error:&error];
        if(parsedJson == nil) {
            [self onError:source error:error];
            return;
        }
        
        NSInteger latest = [[parsedJson objectForKey:type] integerValue];
        [_versionDownloadSupport.userinfo setObject:[NSNumber numberWithInteger:latest] forKey:@"latest"];
        if(latest > val) {
            [self updateUI:^{
                UIAlertController* messageBox =
                    [UIAlertController alertControllerWithTitle:@"Update Found"
                                                        message:@"Do you want to download and install the update?"
                                                 preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* okAction = [UIAlertAction
                                           actionWithTitle:@"OK"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       [self dismissViewControllerAnimated:YES completion:nil];
                                                       if([@"voice" isEqualToString:type]) {
                                                           [_voiceDownloadSupport download];
                                                       }
                                                       if([@"data" isEqualToString:type]) {
                                                           [_dataDownloadSupport download];
                                                       }
                                                   }];
                
                [messageBox addAction: okAction];
                UIAlertAction* cancelAction = [UIAlertAction
                                           actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * action) {
                                                       [self updateDoneRefreshUI: _versionDownloadSupport];
                                                       [self dismissViewControllerAnimated:YES completion:nil];
                                                   }];
                
                [messageBox addAction: cancelAction];
                [self presentViewController:messageBox animated:YES completion:nil];
            }];
            
        } else {
            [self updateUI:^{
                [self showMessageWithInfo:@"Already the latest version"];
                [self updateDoneRefreshUI:source];
            }];
        }
        [self updateUI:^{
            [self.voiceButton setEnabled:YES];
            [self.dataButton setEnabled:YES];
        }];
        return;
    }

    if(source == _voiceDownloadSupport) {
        [self updateVoiceData];
        
    }
    if(source == _dataDownloadSupport) {
        [self updateData];
    }
}

- (void)onProgress:(HttpDownloadSupport*)source progress:(float)progress {
    [self updateUI:^{
        if(source == _voiceDownloadSupport) {
            // 0.2 download, 0.8 unzip
            [self.voiceProgressView setProgress:progress*0.2 animated:YES];
        }
        if(source == _dataDownloadSupport) {
            // Import is expected to be fast
            [self.dataProgressView setProgress:progress animated:YES];
        }
    }];
}

- (void)showMessage:(BOOL)success {
    
    UIAlertController* messageBox =
    [UIAlertController alertControllerWithTitle:success?@"Update Completed":@"Update Failed"
                                        message:success?@"Your data is up to date now.":@"Error occurred during update. Please try again later."
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okAction = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   [self dismissViewControllerAnimated:YES completion:nil];
                               }];
    [messageBox addAction:okAction];
    [self presentViewController:messageBox animated:YES completion:nil];
}

- (void)showMessageWithInfo:(NSString*)info {
    UIAlertController* messageBox =
    [UIAlertController alertControllerWithTitle:@"Prompt"
                                        message:info
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okAction = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   [self dismissViewControllerAnimated:YES completion:nil];
                               }];
    [messageBox addAction:okAction];
    [self presentViewController:messageBox animated:YES completion:nil];
}

- (void)updateDoneRefreshUI:(HttpDownloadSupport*)source {
    if(source == _voiceDownloadSupport) {
        [self.voiceButton setHidden:NO];
        [self.voiceProgressView setHidden:YES];
    }
    if(source == _dataDownloadSupport) {
        [self.dataButton setHidden:NO];
        [self.dataProgressView setHidden:YES];
    }
    if(source == _versionDownloadSupport) {
        [self.dataButton setEnabled:YES];
        [self.voiceButton setEnabled:YES];
        [self.voiceButton setHidden:NO];
        [self.voiceProgressView setHidden:YES];
        [self.dataButton setHidden:NO];
        [self.dataProgressView setHidden:YES];
    }
}

- (void)updateDone:(HttpDownloadSupport*)source success:(BOOL)success {
    if(success) {
        if(source == _voiceDownloadSupport) {
            NSInteger voiceVer = [UserPreference getInteger:SYS_VOICE_VERSION
                                                     defval:SYS_VOICE_VERSION_DEFAULT];
            [self updateUI:^{
                [self.voiceVersionLabel setText:[NSString stringWithFormat:@"%zd",voiceVer]];
            }];
        }
        if(source == _dataDownloadSupport) {
            NSInteger dataVer = [UserPreference getInteger:SYS_DATA_VERSION
                                                    defval:SYS_DATA_VERSION_DEFAULT];
            [self updateUI:^{
                [self.dataVersionLabel setText: [NSString stringWithFormat:@"%zd",dataVer]];
            }];
        }
    }
    [self updateUI:^{
        [self showMessage:success];
        [self updateDoneRefreshUI: source];
    }];
}

- (void)updateVoiceData {
    // Remove old voice file
    NSURL* voiceFolder = [[FileManager appSupportDir] URLByAppendingPathComponent:@"voice" isDirectory:YES];
    //[FileManager delete:voiceFolder];
    
    // Unzip the downloaded file to target
    // This will take considerable time, thus put it in background thread
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *zipPath = [_voiceDownloadSupport.destinationFile path];
        NSString *destinationPath = [[FileManager appSupportDir] path];
        NSError* error = nil;
        BOOL unzipSuccess = [SSZipArchive unzipFileAtPath:zipPath
                                            toDestination:destinationPath
                                                overwrite:YES
                                                 password:nil
                                                    error:&error
                                                 delegate:self];
        if(!unzipSuccess) {
            NSLog(@"Failed to unzip downloaded archieve:%@-%@",error,[error userInfo]);
            [self updateVoiceDataDone:NO];
            return;
        }
        // Change folder privilege
        BOOL success = [voiceFolder setResourceValue: [NSNumber numberWithBool: YES]
                                              forKey: NSURLIsExcludedFromBackupKey
                                               error: &error];
        
        if(!success){
            NSLog(@"Error excluding %@ from backup %@", [voiceFolder lastPathComponent], error);
            [self updateVoiceDataDone:NO];
            return;
        }
        // Update version
        NSInteger latest = [[_versionDownloadSupport.userinfo objectForKey:@"latest"] integerValue];
        [UserPreference setInteger:latest forKey:SYS_VOICE_VERSION];
        [self updateVoiceDataDone:YES];
    });
}

- (void)updateVoiceDataDone:(BOOL)success {
    [self updateDone:_voiceDownloadSupport success:success];
}

- (void)zipArchiveProgressEvent:(NSInteger)loaded total:(NSInteger)total {
    float progress = 0.2 + (((float)loaded) / total)*0.8;
    [self updateUI:^{
        [self.voiceProgressView setProgress:progress];
    }];
}

- (void)zipArchiveDidUnzipArchiveAtPath:(NSString *)path
                                zipInfo:(unz_global_info)zipInfo
                           unzippedPath:(NSString *)unzippedPath {
    return;
}

- (void)updateData {
    NSError* error;
    NSDictionary* parsedJson = [NSJSONSerialization JSONObjectWithData:_dataDownloadSupport.destinationData
                                                               options:NSJSONReadingMutableContainers
                                                                 error:&error];
    if(parsedJson == nil) {
        NSLog(@"Failed to parse data json");
        [self updateDone:_dataDownloadSupport success:NO];
        return;
    }
    BOOL success = [DataImporter importData:parsedJson];
    if(!success) {
        NSLog(@"Failed to import data");
    }
    [self updateDone:_dataDownloadSupport success:success];
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
