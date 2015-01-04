//
//  ExamTimer.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/16/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExamTimer : NSObject {
    NSInteger _timeTarget;
    id _target;
    SEL _intervalFunc;
    SEL _doneFunc;
    
    NSTimer* _timer;
    NSDate* _startTime;
}

@property(nonatomic, readonly) long remain;

- (id)initWithMinutes: (NSInteger) min target:(id) ref interval: (SEL) intfunc done: (SEL) donefunc;
- (void)stop;
@end
