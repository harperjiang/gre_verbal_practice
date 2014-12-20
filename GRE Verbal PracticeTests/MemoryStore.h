//
//  MemoryStore.h
//  GRE Verbal Practice
//
//  A Portable Memory Store used to create Core Data objects
//  Primarily for Testing purpose
//
//  Created by Harper on 12/20/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface MemoryStore : NSObject {
    NSManagedObjectContext* moc;
}

- (NSManagedObjectContext*) memoryContext;
- (NSEntityDescription*) edFromName:(NSString*)name;

@end
