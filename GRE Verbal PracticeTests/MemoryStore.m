//
//  MemoryStore.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/20/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "MemoryStore.h"

@implementation MemoryStore


- (NSManagedObjectContext*) memoryContext {
    if(self->moc != nil)
        return self->moc;
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"GRE_Verbal_Practice" withExtension:@"momd"];
    NSManagedObjectModel *mom = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    if(![psc addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:NULL]) {
        abort();
    }
    moc = [[NSManagedObjectContext alloc] init];
    moc.persistentStoreCoordinator = psc;
    return moc;
}

- (NSEntityDescription*) edFromName:(NSString*)name {
    return [NSEntityDescription entityForName:name inManagedObjectContext: [self memoryContext]];
}

@end
