//
//  ExamTimer.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/16/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "ExamTimer.h"

@implementation ExamTimer

- (id)initWithMinutes:(NSInteger)min target:(id)ref interval:(SEL)intfunc done:(SEL)donefunc {
    self = [super init];
    if(self) {
        self->_timeTarget = min * 60;
        self->_target = ref;
        self->_intervalFunc = intfunc;
        self->_doneFunc = donefunc;
        self->_startTime = [NSDate date];
        self->_timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(update) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)update {
    // Update remain time
    _remain = self->_timeTarget - [[NSDate date] timeIntervalSinceDate:self->_startTime];
    if(_remain <= 0) {
        [self->_timer invalidate];
        
        IMP doneImp = [self->_target methodForSelector:self->_doneFunc];
        void (*doneFunc)(id, SEL) = (void *)doneImp;
        doneFunc(self->_target, self->_doneFunc);
    } else {
        IMP intervalImp = [self->_target methodForSelector:self->_intervalFunc];
        void (*intervalFunc)(id, SEL, NSNumber*) = (void *)intervalImp;
        intervalFunc(self->_target, self->_intervalFunc, [[NSNumber alloc] initWithInteger:_remain]);
    }
}

- (void)stop {
    if([self->_timer isValid])
        [self->_timer invalidate];
}

@end
