//
//  FileManager.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/20/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpDownloadSupport.h"

@interface FileManager : NSObject

+ (NSURL*)appSupportDir;
+ (NSURL*)appCacheDir;
+ (NSURL*)voiceFileFor:(NSString*)word check:(BOOL)c;
+ (BOOL)delete:(NSURL*)target;
@end
