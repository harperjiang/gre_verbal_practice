//
//  DataImporter.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/19/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "DataImporter.h"
#import "DataManager.h"
#import "AppDelegate.h"
#import "SEQuestion.h"
#import "TCQuestion.h"
#import "RCQuestion.h"
#import <CoreData/CoreData.h>

@implementation DataImporter

+ (void)importTestData {
    NSManagedObjectContext* moc = [[DataManager defaultManager] getContext];
    NSEntityDescription* ved = [NSEntityDescription entityForName:@"Vocabulary" inManagedObjectContext:moc];
    NSEntityDescription* seqed = [NSEntityDescription entityForName:@"SEQuestion" inManagedObjectContext:moc];
    NSEntityDescription* tcqed = [NSEntityDescription entityForName:@"TCQuestion" inManagedObjectContext:moc];
    NSEntityDescription* rcqed = [NSEntityDescription entityForName:@"RCQuestion" inManagedObjectContext:moc];
    NSEntityDescription* rcted = [NSEntityDescription entityForName:@"RCText"  inManagedObjectContext:moc];
    // Delete all old data
    [[DataManager defaultManager] deleteAll:@"Vocabulary"];
    [[DataManager defaultManager] deleteAll:@"SEQuestion"];
    [[DataManager defaultManager] deleteAll:@"TCQuestion"];
    [[DataManager defaultManager] deleteAll:@"RCQuestion"];
    [[DataManager defaultManager] deleteAll:@"RCText"];
    
    Vocabulary* test1 = [[Vocabulary alloc] initWithEntity:ved insertIntoManagedObjectContext:moc];
    [test1 setWord:@"good"];
    [test1 setExplanation:@"Good is a good word"];
    [test1 setSamples:@"<No Samples>"];
    [test1 setSynonyms:@"nice"];
    [moc insertObject:test1];
    
    SEQuestion* seq1 = [[SEQuestion alloc] initWithEntity:seqed insertIntoManagedObjectContext:moc];
    [seq1 setText:@"Not only love affects the eye of the beholder; other emotions also ____ the interpretation of the events that we witness."];
    [seq1 setOptions:@[@"cloud",
                       @"trigger",
                       @"devalue",
                       @"color",
                       @"objectify",
                       @"impact"]];
    [seq1 setAnswers:@[@3,@5]];
    [seq1 setExplanation:@"One word from the first part of the sentence seems to be what we need in the blank. The word is ‘affects’. If we see this then we can choose words that will give the meaning ‘affect the interpretation’. Obviously the word ‘impact’ fits. (Note that ‘impact’ is used as a verb here not a noun). For the other word we can consider ‘cloud’ and ‘color’, both of which can be used as verbs. To cloud would imply to obscure and would be negative, whereas to color is not necessarily negative. Hence we are better to take the words ‘impact’ and ‘color’ as they are less restrictive than ‘cloud’."];
    
    [moc insertObject:seq1];
    
    TCQuestion* tcq1 = [[TCQuestion alloc] initWithEntity:tcqed insertIntoManagedObjectContext:moc];
    [tcq1 setText:@"Ricks has written extensively not only on the poetry of such ____ figures in English poetry as Milton and Housman, but also on the less obviously ____ lyrics of Bob Dylan."];
    [tcq1 setOptions:@[@[@"obscurantist",
                         @"arcane",
                         @"established"], @[@"canonical",
                                            @"popular",
                                            @"judicious"]]];
    [tcq1 setAnswers:@[@2,@0]];
    [tcq1 setExplanation:@"The clue is in the words ‘less obviously’ which implies that whatever we say about Miton and Housman will apply ‘less obviously’ to Dylan. Hence we are looking for two words of similar meaning. We could say that Milton and Housman are established figures whereas it is less obvious that the poetry of Dylan is ‘established’. If by established we mean accepted as having literary merit, then the partner word is obviously ‘canonical’, which means exactly that.\n(Arcane – known only to a few; judicious – fair, apt; obscurantist – tending to make things difficult to see)"];
    [moc insertObject:tcq1];
    
    RCText* rct = [[RCText alloc] initWithEntity:rcted insertIntoManagedObjectContext:moc];
    [rct setText:@"Should we really care for the greatest actors of the past could we have them before us? Should we find them too different from our accent of thought, of feeling, of speech, in a thousand minute particulars which are of the essence of all three? Dr. Doran's 5   long and interesting records of the triumphs of Garrick, and other less familiar, but in their day hardly less astonishing, players, do not relieve one of the doubt. Garrick himself, as sometimes happens with people who have been the subject of much anecdote and other conversation, here as elsewhere, bears no very distinct 10  figure. One hardly sees the wood for the trees. On the other hand, the account of Betterton, \"perhaps the greatest of English actors,\" is delightfully fresh. That intimate friend of Dryden, Tillatson, Pope, who executed a copy of the actor's portrait by Kneller which is still extant, was worthy of their friendship; 15  his career brings out the best elements in stage life. The stage in these volumes presents itself indeed not merely as a mirror of life, but as an illustration of the utmost intensity of life, in the fortunes and characters of the players. Ups and downs, generosity, dark fates, the most delicate goodness, have nowhere 20  been more prominent than in the private existence of those devoted to the public mimicry of men and women. Contact with the stage, almost throughout its history, presents itself as a kind of touchstone, to bring out the bizarrerie, the theatrical tricks and contrasts, of the actual world."];
    [moc insertObject:rct];
    
    RCQuestion* rcq = [[RCQuestion alloc] initWithEntity:rcqed insertIntoManagedObjectContext:moc];
    [rcq setText:@"In the expression “One hardly sees the wood for the trees”, the author apparently intends the word trees to be analogous to"];
    [rcq setOptions:@[@"features of Doran’s language style",
                      @"details learned from oral sources",
                      @"personality of a famous actor",
                      @"detail’s of Garrick’s life",
                      @"stage triumphs of an astonishing player"]];
    [rcq setAnswers:@[@1]];
    [rcq setExplanation:@"The “wood” refers to the bigger picture, the “trees” to the details. One apparently does not get a picture of Garrick the man, but one does get along and interesting record of his triumphs. We are also told that Garrick has been the subject of much conversation and anecdote. Hence the “trees” refers to the details of Garrick’s life learned mainly from oral sources."];
    [rcq setReadText:rct];
    [moc insertObject:rcq];
    
    
    NSError* error;
    if(![moc save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
}

+ (void)importData:(NSDictionary *)data {
    
}

@end
