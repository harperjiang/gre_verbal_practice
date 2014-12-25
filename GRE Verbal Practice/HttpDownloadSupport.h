//
//  HttpDownloadSupport.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/23/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HttpDownloadSupport;

@protocol HttpDownloadListener<NSObject>

- (void)onError:(HttpDownloadSupport*)source error:(NSError*)error;
- (void)onSuccess:(HttpDownloadSupport*)source;

- (void)onProgress:(HttpDownloadSupport*)source progress:(float)progress;

@end

@interface HttpDownloadSupport : NSObject<NSURLConnectionDelegate,NSURLConnectionDataDelegate,NSStreamDelegate> {
    NSURLConnection* _connection;
    NSMutableData* _receivedData;
    NSOutputStream* _outputStream;
    NSUInteger _expectedLength;
    NSUInteger _progressLength;
    NSLock* _dataLock;
    BOOL _receiveDone;
}

@property(nonatomic, readonly) BOOL inMemory;
@property(nonatomic, readwrite, strong) id<HttpDownloadListener> listener;
@property(nonatomic, readwrite, strong) NSString* targetURL;
@property(nonatomic, readwrite, strong) NSURL* destinationFile;
@property(nonatomic, readonly, strong) NSData* destinationData;
@property(nonatomic, readwrite) NSInteger timeout;
@property(nonatomic, readwrite, strong) NSMutableDictionary* userinfo;

- (id)init:(BOOL)inMemory;
- (void)download;

@end
