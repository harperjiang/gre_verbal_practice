//
//  RCText.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/9/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RCParagraph : NSObject

@property(nonatomic, readwrite, retain) NSArray* sentences;
    
@end


@interface RCText : NSObject

@property(nonatomic, readwrite, retain) NSArray* paragraphs;
@property(nonatomic, readwrite, strong) NSString* text;

-(NSString*) toString;

@end
