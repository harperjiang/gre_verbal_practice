//
//  DataModelTest.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/19/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <CoreData/CoreData.h>
#import "Vocabulary.h"
#import "SEQuestion.h"
#import "MemoryStore.h"


@interface DataModelTest : XCTestCase {
    MemoryStore* memoryStore;
}

@end

@implementation DataModelTest

- (void)setUp {
    [super setUp];
    memoryStore = [[MemoryStore alloc] init];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testVocabulary {
    NSManagedObjectContext* moc = [memoryStore memoryContext];
    Vocabulary* insert = [[Vocabulary alloc] initWithEntity: [memoryStore edFromName:@"Vocabulary"] insertIntoManagedObjectContext: moc];
    insert.word = @"Test";
    insert.explanation = @"Test Explanation";
    insert.synonyms = @"DSFDSF";
    insert.samples = @"SDFfwefew";
    
    [moc insertObject: insert];
    NSError* error;
    XCTAssert([moc save:&error]);
    
    NSFetchRequest *fetch = [[NSFetchRequest alloc] initWithEntityName:@"Vocabulary"];

    NSArray* result = [moc executeFetchRequest:fetch error:&error];
    XCTAssert(result != nil);
    
    XCTAssertEqualObjects(@"Test", [(Vocabulary*)[result objectAtIndex:0] word]);
}

- (void)testQuestion {
    NSManagedObjectContext* moc = [memoryStore memoryContext];
    SEQuestion* question = [[SEQuestion alloc] initWithEntity: [memoryStore edFromName:@"SEQuestion"] insertIntoManagedObjectContext: moc];
    [question setText:@"Sample Question"];
    [question setOptions:@[@"ABCDEFG",@"HIJKLMN"]];
    [question setAnswers:@[@0,@1]];
    
    [moc insertObject: question];
    NSError* error;
    XCTAssert([moc save:&error]);
    
    NSFetchRequest *fetch = [[NSFetchRequest alloc] initWithEntityName:@"SEQuestion"];
    
    NSArray* result = [moc executeFetchRequest:fetch error:&error];
    XCTAssert(result != nil);
    
    XCTAssert([[result objectAtIndex:0] isKindOfClass:SEQuestion.class]);
    SEQuestion* seq = (SEQuestion*)[result objectAtIndex:0];
    XCTAssertEqualObjects(@"Sample Question", seq.text);
    NSArray* opt = @[@"ABCDEFG",@"HIJKLMN"];
    XCTAssertEqualObjects(opt, seq.options);
    NSArray* ans = @[@0,@1];
    XCTAssertEqualObjects(ans, seq.answers);
}

@end
