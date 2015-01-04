//
//  QuestionPlanTest.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/19/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "QuestionSet.h"
#import "SEQuestion.h"
#import "MemoryStore.h"

@interface QuestionSetTest : XCTestCase {
    QuestionSet* target;
    QuestionSet* empty;
    
    MemoryStore* mstore;
}

@end

@implementation QuestionSetTest

- (void)setUp {
    [super setUp];
    mstore = [[MemoryStore alloc] init];
    NSManagedObjectContext* moc = [mstore memoryContext];
    NSEntityDescription *qsed = [mstore edFromName:@"QuestionSet"];
    empty = [[QuestionSet alloc] initWithEntity:qsed insertIntoManagedObjectContext:moc];
    
    target = [[QuestionSet alloc] initWithEntity:qsed insertIntoManagedObjectContext:moc];
    [target setType: SENTENCE_EQUIV];
    NSMutableOrderedSet* questions = [[NSMutableOrderedSet alloc] init];
    
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
    target = nil;
}

- (void)testEmptyQuestionSet {
    XCTAssert([empty question] == nil, @"Empty QuestionSet emit nil for next Question");
    XCTAssert(![empty prev]);
    XCTAssert(![empty next]);
}

- (void)testNextQuestion {
    
    XCTAssert([target current] == 0);
    XCTAssert(![target prev]);
    Question* q = [target question];
    
    XCTAssert([q isKindOfClass:[SEQuestion class]]);
    SEQuestion* seq = (SEQuestion*)q;
    
    XCTAssertEqual(@"Test a", seq.text);

    XCTAssert([target next]);
    XCTAssert([target current] == 1);
    q = [target question];
    
    XCTAssert([q isKindOfClass:[SEQuestion class]]);
    seq = (SEQuestion*)q;
    
    XCTAssertEqual(@"Test b", seq.text);
    
    XCTAssert(![target next]);
    XCTAssert([target current] == 1);
    
    XCTAssert([target prev]);
    q = [target question];
    
    XCTAssert([q isKindOfClass:[SEQuestion class]]);
    seq = (SEQuestion*)q;
    
    XCTAssertEqual(@"Test a", seq.text);
    XCTAssert(![target prev]);
}

- (void)testScore {
    [target question];
    [target answer:[Question emptyAnswer]];
    [target next];
    [target answer:@[@0,@1]];
    
    XCTAssertEqualObjects(@"1/2", [target score]);

    [target answer:@[@0,@2] index:0];
    [target answer:@[@0,@1] index:1];
    XCTAssertEqualObjects(@"2/2", [target score]);

}

@end
