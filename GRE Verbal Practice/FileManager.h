//
//  FileManager.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/20/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManager : NSObject

+ (NSURL*)appSupportDir;

+ (NSURL*)voiceFileFor:(NSString*)word;


@end
