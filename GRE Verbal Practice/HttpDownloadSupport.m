//
//  HttpDownloadSupport.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/23/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "HttpDownloadSupport.h"

@implementation HttpDownloadSupport


- (id)init:(BOOL)inMemory {
    self = [super init];
    if(self) {
        self->_inMemory = inMemory;
        self.timeout = 10;
        self->_dataLock = [[NSLock alloc] init];
        self.userinfo = [[NSMutableDictionary alloc] initWithCapacity:10];
    }
    return self;
}

- (void)openOutputStream {
    NSError* error = nil;
    NSString* folder = [self.destinationFile.path stringByDeletingLastPathComponent];
    if(![[NSFileManager defaultManager] createDirectoryAtPath:folder
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error: &error]) {
        NSLog(@"Failed to create folder for file %@, %@-%@",self.destinationFile.path, error, error.userInfo);
    }
    _outputStream = [NSOutputStream outputStreamWithURL:self.destinationFile append:NO];
    [_outputStream setDelegate:self];
    [_outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop]
                       forMode:NSDefaultRunLoopMode];
    [_outputStream open];
}

- (void)download {
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:self.targetURL]
                                              cachePolicy:NSURLRequestReloadIgnoringCacheData
                                          timeoutInterval:self.timeout];
    
    // Create the NSMutableData to hold the received data.
    _receivedData = [NSMutableData dataWithCapacity: 0];
    if(!self.inMemory) {
        [self openOutputStream];
    }
    // create the connection with the request
    // and start loading the data
    _connection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    if (!_connection) {
        // Release the receivedData object.
        [self error:nil];
    }
}

- (void)error:(NSError*)error {
    _receivedData = nil;
    [_connection cancel];
    if(!self.inMemory) {
        [_outputStream close];
        _outputStream = nil;
    }
    // inform the user
    if(self.listener != nil) {
        [self.listener onError:self error:error];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSHTTPURLResponse* resp = (NSHTTPURLResponse*)response;
    if(resp.statusCode != 200) {
        [self error:[[NSError alloc] initWithDomain:@"HttpDownloadDomain" code:resp.statusCode userInfo:@{}]];
        return;
    }
    
    [_receivedData setLength:0];
    if(!self.inMemory) {
        // Close and reopen
        [_outputStream close];
        [self openOutputStream];
    }
    _expectedLength = (NSUInteger)[response expectedContentLength];
    _progressLength = 0;
    _receiveDone = NO;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to receivedData.
    [_receivedData appendData:data];
    
    _progressLength += data.length;
    if(self.listener != nil && _expectedLength != 0) {
        [self.listener onProgress:self progress:((float)_progressLength)/_expectedLength];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self error:error];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    _receiveDone = YES;
    [self cleanAndQuit];
}

- (void)writeToOutput {
    if(_receivedData.length > 0) {
        uint8_t *readBytes = (uint8_t *)[_receivedData mutableBytes];
        [_outputStream write:readBytes maxLength: _receivedData.length];
        [_receivedData setLength:0];
    }
}

- (void)cleanAndQuit {
    if(self.inMemory) {
        self->_destinationData = self->_receivedData;
    } else {
        // Always attempts a write
        [self writeToOutput];
        [_outputStream close];
        _receivedData = nil;
    }
    if(self.listener != nil) {
        [self.listener onSuccess:self];
    }
}


- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)eventCode {
    switch(eventCode) {
        case NSStreamEventHasSpaceAvailable: {
            [self writeToOutput];
            break;
        }
        case NSStreamEventErrorOccurred: {
            NSLog(@"Error when writing files");
            [self error:nil];
            break;
        }
        default:
            break;
    }
}

@end
