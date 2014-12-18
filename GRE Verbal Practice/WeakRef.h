//
//  WeakRef.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/18/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeakRef : NSObject

@property(nonatomic, readwrite, weak) id reference;

@end
