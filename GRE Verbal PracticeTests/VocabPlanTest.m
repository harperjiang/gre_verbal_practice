//
//  VocabPlanTest.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/19/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "VocabPlan.h"
#import "MemoryStore.h"

@interface VocabPlanTest : XCTestCase {
    VocabPlan* empty;
    VocabPlan* target;
    
    MemoryStore* mstore;
}

@end

@implementation VocabPlanTest

- (void)setUp {
    [super setUp];
    mstore = [[MemoryStore alloc] init];
    
    NSEntityDescription *ved = [mstore edFromName:@"Vocabulary"];
    
    empty = [[VocabPlan alloc] init];
    
    target = [[VocabPlan alloc] init];
    
    NSMutableArray* vocabs = [[NSMutableArray alloc] init];
    
    Vocabulary* v = [[Vocabulary alloc] initWithEntity:ved insertIntoManagedObjectContext:[mstore memoryContext]];
    [v setWord:@"abacus"];
    [vocabs addObject:v];
    
    Vocabulary* v2 = [[Vocabulary alloc] initWithEntity:ved insertIntoManagedObjectContext:[mstore memoryContext]];;
    [v2 setWord:@"dalliance"];
    [vocabs addObject:v2];
    
    [target setWords:vocabs];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testNextVocab {
    XCTAssert([empty nextVocab] == nil);
    for(int i = 0 ; i < 100; i++)
        XCTAssert([target nextVocab]!= nil);
}

- (void)testFeedback {
    [empty feedback:YES];
    
    [target nextVocab];
    [target feedback:YES];
    [target nextVocab];
    [target feedback:NO];
    [target nextVocab];
    [target feedback:YES];
    XCTAssert([target nextVocab] == nil);
}

- (void)testStatus {
    [target nextVocab];
    XCTAssertEqualObjects(@"This round: 2/2", [target status]);
}

@end
