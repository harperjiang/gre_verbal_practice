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
#import "ExamSuite.h"
#import "UserPreference.h"
#import <CoreData/CoreData.h>

@implementation DataImporter

+ (void)importTestData {
    NSManagedObjectContext* moc = [[DataManager defaultManager] getContext];
    NSEntityDescription* ved = [NSEntityDescription entityForName:@"Vocabulary" inManagedObjectContext:moc];
    NSEntityDescription* seqed = [NSEntityDescription entityForName:@"SEQuestion" inManagedObjectContext:moc];
    NSEntityDescription* tcqed = [NSEntityDescription entityForName:@"TCQuestion" inManagedObjectContext:moc];
    NSEntityDescription* rcqed = [NSEntityDescription entityForName:@"RCQuestion" inManagedObjectContext:moc];
    NSEntityDescription* rcted = [NSEntityDescription entityForName:@"RCText"  inManagedObjectContext:moc];
    NSEntityDescription* esed = [NSEntityDescription entityForName:@"ExamSuite" inManagedObjectContext:moc];
    // Delete all old data
    [[DataManager defaultManager] deleteAll:@"Vocabulary"];
    [[DataManager defaultManager] deleteAll:@"SEQuestion"];
    [[DataManager defaultManager] deleteAll:@"TCQuestion"];
    [[DataManager defaultManager] deleteAll:@"RCQuestion"];
    [[DataManager defaultManager] deleteAll:@"RCText"];
    [[DataManager defaultManager] deleteAll:@"ExamSuite"];
    
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
    
    NSMutableOrderedSet* questions = [[NSMutableOrderedSet alloc] init];
    [questions addObject:rcq];
    [questions addObject:tcq1];
    [questions addObject:seq1];
    
    ExamSuite* es1 = [[ExamSuite alloc] initWithEntity:esed insertIntoManagedObjectContext:moc];
    [es1 setName:@"Test ExamSuite"];
    [es1 setStatistics:@"Tried 1 times, Success rate 24%"];
    [es1 setQuestions:questions];
    [es1 setTimeLimit:30];
    [moc insertObject:es1];
    
    NSError* error;
    if(![moc save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
}


+ (BOOL)importData:(NSDictionary *)data {
    NSInteger dataVersion = [(NSNumber*)[data objectForKey:@"version"] integerValue];
   
    NSInteger currentVersion = [UserPreference getInteger:SYS_DATA_VERSION
                                                   defval:SYS_DATA_VERSION_DEFAULT];
    if(dataVersion <= currentVersion) {
        return YES;
    }
    
    DataManager* dm = [DataManager defaultManager];
    NSManagedObjectContext* moc = [dm getContext];
    NSEntityDescription* ved = [NSEntityDescription entityForName:@"Vocabulary"
                                           inManagedObjectContext:moc];
    NSEntityDescription* seed = [NSEntityDescription entityForName:@"SEQuestion"
                                           inManagedObjectContext:moc];
    NSEntityDescription* tced = [NSEntityDescription entityForName:@"TCQuestion"
                                           inManagedObjectContext:moc];
    NSEntityDescription* rcted = [NSEntityDescription entityForName:@"RCText"
                                           inManagedObjectContext:moc];
    NSEntityDescription* rced = [NSEntityDescription entityForName:@"RCQuestion"
                                           inManagedObjectContext:moc];
    
    BOOL replaceOld = [(NSNumber*)[data objectForKey:@"replace"] boolValue];
    if(replaceOld) {
        [dm deleteAll];
    }
    
    // Check Vocabulary Update
    NSArray* vocArray = (NSArray*)[data objectForKey:@"vocabularies"];
    if(vocArray != nil) {
        for(NSDictionary* vocData in vocArray) {
            Vocabulary* voc = [[Vocabulary alloc] initWithEntity:ved
                                  insertIntoManagedObjectContext:moc];
            [voc setWord: [vocData objectForKey:@"word"]];
            [voc setExplanation:[vocData objectForKey:@"explanation"]];
            [voc setSamples:[vocData objectForKey:@"samples"]];
            [voc setSynonyms:[vocData objectForKey:@"synonyms"]];
            [voc setPassCount:0];
            [voc setScheduleDate:nil];
            [moc insertObject:voc];
        }
    }
    
    NSArray* seQuestions = (NSArray*)[data objectForKey:@"seQuestions"];
    if(seQuestions != nil) {
        for(NSDictionary* seqData in seQuestions) {
            SEQuestion* question = [[SEQuestion alloc] initWithEntity:seed insertIntoManagedObjectContext:moc];
            [question setText:[seqData objectForKey:@"text"]];
            [question setOptions:[seqData objectForKey:@"options"]];
            [question setAnswers:[seqData objectForKey:@"answers"]];
            [question setExplanation:[seqData objectForKey:@"explanation"]];
            [moc insertObject:question];
        }
    }
    
    NSArray* tcQuestions = (NSArray*)[data objectForKey:@"tcQuestions"];
    if(tcQuestions != nil) {
        for(NSDictionary* tcqData in tcQuestions) {
            TCQuestion* question = [[TCQuestion alloc] initWithEntity:tced insertIntoManagedObjectContext:moc];
            [question setText:[tcqData objectForKey:@"text"]];
            [question setOptions:[tcqData objectForKey:@"options"]];
            [question setAnswers:[tcqData objectForKey:@"answers"]];
            [question setExplanation:[tcqData objectForKey:@"explanation"]];
            [moc insertObject:question];
        }
    }
    
    NSDictionary* rcTextDatas = (NSDictionary*)[data objectForKey:@"rcTexts"];
    NSArray* rcQuestions = (NSArray*)[data objectForKey:@"rcQuestions"];
    if(rcTextDatas != nil && rcQuestions != nil) {
        NSMutableDictionary* rcTexts = [[NSMutableDictionary alloc] initWithCapacity:rcTextDatas.count];
        [rcTextDatas enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL* stop) {
            RCText* rcText = [[RCText alloc] initWithEntity:rcted
                             insertIntoManagedObjectContext:moc];
            [rcText setText: value];
            [rcTexts setObject:rcText forKey:key];
            [moc insertObject:rcText];
        }];
        for(NSDictionary* rcqData in rcQuestions) {
            RCQuestion* question = [[RCQuestion alloc] initWithEntity:rced insertIntoManagedObjectContext:moc];
            [question setText:[rcqData objectForKey:@"text"]];
            [question setOptions:[rcqData objectForKey:@"options"]];
            [question setAnswers:[rcqData objectForKey:@"answers"]];
            [question setExplanation:[rcqData objectForKey:@"explanation"]];
            [question setReadText: (RCText*)[rcTexts objectForKey:[rcqData objectForKey:@"readText"]]];
            [moc insertObject:question];
        }
    }
    
    if([dm save]) {
        [UserPreference setInteger:dataVersion forKey:SYS_DATA_VERSION];
        return YES;
    }
    return NO;
}

@end
