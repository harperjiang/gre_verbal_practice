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
    
    empty = [[QuestionSet alloc] init];
    
    target = [[QuestionSet alloc] init];
    [target setType: SENTENCE_EQUIV];
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
    target = nil;
}

- (void)testEmptyQuestionSet {
    XCTAssert([empty nextQuestion] == nil, @"Empty QuestionSet emit nil for next Question");
}

- (void)testNextQuestion {
    Question* q = [target nextQuestion];
    
    XCTAssert([q isKindOfClass:[SEQuestion class]]);
    SEQuestion* seq = (SEQuestion*)q;
    
    XCTAssertEqual(@"Test a", seq.text);

    q = [target nextQuestion];
    
    XCTAssert([q isKindOfClass:[SEQuestion class]]);
    seq = (SEQuestion*)q;
    
    XCTAssertEqual(@"Test b", seq.text);
    
    XCTAssert([target nextQuestion] == nil);
}

- (void)testScore {
    [target nextQuestion];
    [target answer:[Question emptyAnswer]];
    [target nextQuestion];
    [target answer:@[@0,@1]];
    
    XCTAssertEqualObjects(@"1/2", [target score]);

    [target answer:@[@0,@2] index:0];
    [target answer:@[@0,@1] index:1];
    XCTAssertEqualObjects(@"2/2", [target score]);

}

@end
