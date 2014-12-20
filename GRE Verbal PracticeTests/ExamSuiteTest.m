//
//  ExamSuiteTest.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/19/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ExamSuite.h"
#import "SEQuestion.h"
#import "MemoryStore.h"

@interface ExamSuiteTest : XCTestCase

@end

@implementation ExamSuiteTest {
    ExamSuite* target;
    ExamSuite* empty;
    
    MemoryStore* mstore;
}

- (void)setUp {
    [super setUp];
    
    empty = [[ExamSuite alloc] init];
    
    target = [[ExamSuite alloc] init];
    
    mstore = [[MemoryStore alloc] init];
    
    NSMutableArray* questions = [[NSMutableArray alloc] init];
    
    SEQuestion* q1 = [[SEQuestion alloc] initWithEntity:[mstore edFromName: @"SEQuestion"] insertIntoManagedObjectContext:[mstore memoryContext]];
    [q1 setText:@"Test a"];
    [q1 setOptions:@[@"OptionA",@"OptionB",@"OptionC"]];
    [q1 setAnswers:@[@0,@2]];
    [questions addObject:q1];
    
    
    SEQuestion* q2 = [[SEQuestion alloc] initWithEntity:[mstore edFromName: @"SEQuestion"] insertIntoManagedObjectContext:[mstore memoryContext]];
    [q2 setText:@"Test b"];
    [q2 setOptions:@[@"OptionX",@"OptionY",@"OptionZ"]];
    [q2 setAnswers:@[@0,@1]];
    [questions addObject:q2];
    
    [target setQuestions:questions];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testSize {
    XCTAssertEqual(0, [empty size]);
    XCTAssertEqual(2, [target size]);
}

- (void)testQuestion {
    XCTAssert(nil == [empty question]);
    XCTAssert(![empty prev]);
    XCTAssert(![empty next]);
    
    XCTAssertEqualObjects(@"Test a", [target question].text);
    XCTAssertEqual(0, target.current);
    XCTAssert([target next]);
    XCTAssertEqualObjects(@"Test b", [target question].text);
    XCTAssertEqual(1, target.current);
    XCTAssert(![target next]);
    XCTAssertEqual(1, target.current);
    XCTAssert([target prev]);
    XCTAssertEqual(0, target.current);
    XCTAssertEqualObjects(@"Test a", [target question].text);
    XCTAssert(![target prev]);
    XCTAssertEqualObjects(@"Test a", [target question].text);
}

- (void)testAnswer {
    [target answer:@[@0,@2] for: 0];
    [target answer:@[@2,@3] for: 1];
    XCTAssertEqualObjects(@"1/2", [target score]);
}

@end
