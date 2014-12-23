//
//  FileManager.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/20/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "FileManager.h"

@implementation FileManager

static NSURL* appSupportDir;

+ (NSURL*)appSupportDir {
    if(appSupportDir != nil) {
        return appSupportDir;
    }
    
    NSFileManager* fm = [NSFileManager defaultManager];
    NSArray* possibleURLs = [fm URLsForDirectory:NSApplicationSupportDirectory
                                             inDomains:NSUserDomainMask];
    if ([possibleURLs count] >= 1) {
        // Use the first directory (if multiple are returned)
        appSupportDir = [possibleURLs objectAtIndex:0];
    }
    NSError*  error = nil;
    if (![fm createDirectoryAtURL:appSupportDir withIntermediateDirectories:YES
                       attributes:nil error:&error]) {
        // Handle the error.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return appSupportDir;
}

+ (NSURL*)voiceFileFor:(NSString *)word {
    NSURL* voiceRoot = [[FileManager appSupportDir] URLByAppendingPathComponent:@"voice" isDirectory:YES];
    NSURL* voiceFolder = [voiceRoot URLByAppendingPathComponent:[NSString stringWithFormat: @"%C", [[word uppercaseString] characterAtIndex:0]] isDirectory:YES];
    
    NSURL* voiceFile = [voiceFolder URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp3", word]];
    return [voiceFile checkResourceIsReachableAndReturnError:nil]?voiceFile:nil;
}

@end
