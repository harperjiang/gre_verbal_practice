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
#import "QuestionSet.h"
#import "UserPreference.h"
#import <CoreData/CoreData.h>

@implementation DataImporter

+ (void)importTestData {
    NSManagedObjectContext* moc = [[DataManager defaultManager] getContext];
    NSEntityDescription* ved = [NSEntityDescription entityForName:@"Vocabulary" inManagedObjectContext:moc];
    NSEntityDescription* vged = [NSEntityDescription entityForName:@"VocabGroup" inManagedObjectContext:moc];
    NSEntityDescription* seqed = [NSEntityDescription entityForName:@"SEQuestion" inManagedObjectContext:moc];
    NSEntityDescription* tcqed = [NSEntityDescription entityForName:@"TCQuestion" inManagedObjectContext:moc];
    NSEntityDescription* rcqed = [NSEntityDescription entityForName:@"RCQuestion" inManagedObjectContext:moc];
    NSEntityDescription* rcted = [NSEntityDescription entityForName:@"RCText"  inManagedObjectContext:moc];
    NSEntityDescription* esed = [NSEntityDescription entityForName:@"ExamSuite" inManagedObjectContext:moc];
    NSEntityDescription* qsed = [NSEntityDescription entityForName:@"QuestionSet" inManagedObjectContext:moc];
    // Delete all old data
    [[DataManager defaultManager] deleteAll];
    
    VocabGroup* group = [[VocabGroup alloc] initWithEntity:vged insertIntoManagedObjectContext:moc];
    [group setName:@"Test Vocab Group 1"];
    [group setDetail:@"This is some detail"];
    
    VocabGroup* group2 = [[VocabGroup alloc] initWithEntity:vged insertIntoManagedObjectContext:moc];
    [group2 setName:@"Test Vocab Group 2"];
    [group2 setDetail:@"This is some detail"];
    
    
    Vocabulary* test1 = [[Vocabulary alloc] initWithEntity:ved insertIntoManagedObjectContext:moc];
    [test1 setWord:@"good"];
    [test1 setExplanation:@"Good is a good word"];
    [test1 setSamples:@"<No Samples>"];
    [test1 setSynonyms:@"nice"];
    [moc insertObject:test1];
    
    Vocabulary* word2 = [[Vocabulary alloc] initWithEntity:ved insertIntoManagedObjectContext:moc];
    [word2 setWord:@"bad"];
    [word2 setExplanation:@"Bad is a bad word"];
    [word2 setSamples:@"<No Sample>"];
    [word2 setSynonyms:@"wrong"];
    [moc insertObject:word2];
    
    NSMutableSet* vocabs = [[NSMutableSet alloc] init];
    [vocabs addObject:test1];
    [group setVocabularies:vocabs];
    [moc insertObject:group];
    
    NSMutableSet* vocabs2 = [[NSMutableSet alloc] init];
    [vocabs2 addObject:word2];
    [group2 setVocabularies:vocabs2];
    [moc insertObject:group2];
    
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
    
    SEQuestion* seq2 = [[SEQuestion alloc] initWithEntity:seqed insertIntoManagedObjectContext:moc];
    [seq2 setText:@"I am Question 2. Not only love affects the eye of the beholder; other emotions also ____ the interpretation of the events that we witness."];
    [seq2 setOptions:@[@"cloud",
                       @"trigger",
                       @"devalue",
                       @"color",
                       @"objectify",
                       @"impact"]];
    [seq2 setAnswers:@[@3,@5]];
    [seq2 setExplanation:@"One word from the first part of the sentence seems to be what we need in the blank. The word is ‘affects’. If we see this then we can choose words that will give the meaning ‘affect the interpretation’. Obviously the word ‘impact’ fits. (Note that ‘impact’ is used as a verb here not a noun). For the other word we can consider ‘cloud’ and ‘color’, both of which can be used as verbs. To cloud would imply to obscure and would be negative, whereas to color is not necessarily negative. Hence we are better to take the words ‘impact’ and ‘color’ as they are less restrictive than ‘cloud’."];
    
    [moc insertObject:seq2];
    
    QuestionSet* seqs = [[QuestionSet alloc] initWithEntity:qsed insertIntoManagedObjectContext:moc];
    [seqs setName:@"Sentence Equivalance Set 1"];
    NSMutableOrderedSet* qss = [[NSMutableOrderedSet alloc] init];
    [qss addObject:seq1];
    [qss addObject:seq2];
    [seqs setType:SENTENCE_EQUIV];
    [seqs setQuestions:qss];
    [moc insertObject:seqs];
    
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
    [rct setText:@"Should we really care for the greatest actors of the past could\nwe have them before us? Should we find them too different from\nour accent of thought, of feeling, of speech, in a thousand minute\nparticulars which are of the essence of all three? Dr. Doran's\nlong and interesting records of the triumphs of Garrick, and other\nless familiar, but in their day hardly less astonishing, players,\ndo not relieve one of the doubt. Garrick himself, as sometimes\nhappens with people who have been the subject of much anecdote\nand other conversation, here as elsewhere, bears no very distinct\nfigure. One hardly sees the wood for the trees. On the other hand,"];
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
    
    QuestionSet* rcqs = [[QuestionSet alloc] initWithEntity:qsed insertIntoManagedObjectContext:moc];
    [rcqs setName:@"Reading Comprehension Set 1"];
    qss = [[NSMutableOrderedSet alloc] init];
    [qss addObject:rcq];
    [rcqs setType:READING_COMP];
    [rcqs setQuestions:qss];
    [moc insertObject:rcqs];
    
    NSMutableOrderedSet* questions = [[NSMutableOrderedSet alloc] init];
    [questions addObject:rcq];
    [questions addObject:tcq1];
    [questions addObject:seq1];
    
    ExamSuite* es1 = [[ExamSuite alloc] initWithEntity:esed insertIntoManagedObjectContext:moc];
    [es1 setName:@"Test ExamSuite"];
    [es1 setStatistics:@"Tried 1 times, Success rate 24%"];
    [es1 setQuestions:questions];
    [es1 setTimeLimit: [NSNumber numberWithInt:30]];
    [moc insertObject:es1];
    
    qss = [[NSMutableOrderedSet alloc] init];
    [qss addObject:tcq1];
    QuestionSet* qs1 = [[QuestionSet alloc] initWithEntity:qsed insertIntoManagedObjectContext:moc];
    [qs1 setType:TEXT_COMPLETION];
    [qs1 setName:@"Text Completion Set 1"];
    [qs1 setQuestions:qss];
    [moc insertObject:qs1];
    
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
    NSEntityDescription* vged = [NSEntityDescription entityForName:@"VocabGroup"
                                            inManagedObjectContext:moc];
    NSEntityDescription* qsed = [NSEntityDescription entityForName:@"QuestionSet"
                                            inManagedObjectContext:moc];
    NSEntityDescription* esed = [NSEntityDescription entityForName:@"ExamSuite"
                                            inManagedObjectContext:moc];
    
    BOOL replaceOld = [(NSNumber*)[data objectForKey:@"replace"] boolValue];
    if(replaceOld) {
        [dm deleteAll];
    }
    
    // Check Vocabulary Update
    NSArray* vocGroups = (NSArray*)[data objectForKey:@"vocab_groups"];
    if(vocGroups != nil) {
        for(NSDictionary* vocGroup in vocGroups) {
            VocabGroup* group = [[VocabGroup alloc] initWithEntity:vged insertIntoManagedObjectContext:moc];
            group.uid = [vocGroup objectForKey:@"uid"];
            group.name = [vocGroup objectForKey:@"name"];
            group.detail = [vocGroup objectForKey:@"detail"];
            
            NSArray* vocabDatas = [vocGroup objectForKey:@"vocabularies"];
            NSMutableSet* vocabs = [[NSMutableSet alloc] init];
            for(NSDictionary* vocData in vocabDatas) {
                Vocabulary* voc = [[Vocabulary alloc] initWithEntity:ved
                                  insertIntoManagedObjectContext:moc];
                [voc setWord: [vocData objectForKey:@"word"]];
                [voc setExplanation:[vocData objectForKey:@"explanation"]];
                [voc setSamples:[vocData objectForKey:@"sample"]];
                [voc setSynonyms:[vocData objectForKey:@"synonyms"]];
                [voc setPassCount:0];
                [voc setScheduleDate:nil];
                [moc insertObject:voc];
                [vocabs addObject:voc];
            }
            [group setVocabularies:vocabs];
            if([@"" isEqualToString: group.detail]) {
                group.detail = [NSString stringWithFormat:@"Total %zd words", vocabs.count];
            }
            [moc insertObject: group];
        }
    }
    
    // Exam Suite Update
    NSArray* esDatas = (NSArray*)[data objectForKey:@"exam_suites"];
    if(esDatas != nil) {
        for(NSDictionary* esData in esDatas) {
            ExamSuite* es = [[ExamSuite alloc] initWithEntity:esed
                               insertIntoManagedObjectContext:moc];
            es.uid = [esData objectForKey:@"uid"];
            es.name = [esData objectForKey:@"name"];
            es.statistics = [esData objectForKey:@"detail"];
            es.difficulty = [esData objectForKey:@"difficulty"];
            es.timeLimit = [esData objectForKey:@"timeLimit"];
            if(es.timeLimit.intValue == 0) {
                es.timeLimit = [NSNumber numberWithInt:30];
            }
            
            NSOrderedSet* questions = [DataImporter extractQuestions: (NSArray*)[esData objectForKey:@"questions"]];
            [es setQuestions:questions];
            [moc insertObject: es];
        }
    }
    
    // QuestionSets
    NSArray* qsDatas = (NSArray*)[data objectForKey:@"question_sets"];
    if(qsDatas != nil) {
        for(NSDictionary* qsData in qsDatas) {
            QuestionSet* qs = [[QuestionSet alloc] initWithEntity:qsed
                               insertIntoManagedObjectContext:moc];
            qs.uid = [qsData objectForKey:@"uid"];
            qs.name = [qsData objectForKey:@"name"];
            qs.difficulty = [qsData objectForKey:@"difficulty"];
            qs.type = (QuestionType)[[qsData objectForKey:@"type"] integerValue];
            
            NSOrderedSet* questions = [DataImporter extractQuestions: (NSArray*)[qsData objectForKey:@"questions"]];
            [qs setQuestions:questions];
            [moc insertObject: qs];
        }
    }
    
    if([dm save]) {
        [UserPreference setInteger:dataVersion forKey:SYS_DATA_VERSION];
        return YES;
    }
    return NO;
}

+ (NSOrderedSet*) extractQuestions:(NSArray*) data {
    DataManager* dm = [DataManager defaultManager];
    NSManagedObjectContext* moc = [dm getContext];
    
    NSEntityDescription* seed = [NSEntityDescription entityForName:@"SEQuestion"
                                            inManagedObjectContext:moc];
    NSEntityDescription* tced = [NSEntityDescription entityForName:@"TCQuestion"
                                            inManagedObjectContext:moc];
    NSEntityDescription* rcted = [NSEntityDescription entityForName:@"RCText"
                                             inManagedObjectContext:moc];
    NSEntityDescription* rced = [NSEntityDescription entityForName:@"RCQuestion"
                                            inManagedObjectContext:moc];
    NSMutableOrderedSet* result = [[NSMutableOrderedSet alloc] init];
    
    RCText* rctext = nil;
    for(NSDictionary* qd in data) {
        QuestionType type = (QuestionType) [[qd objectForKey:@"type"] integerValue];
        switch (type) {
            case SENTENCE_EQUIV: {
                SEQuestion* question = [[SEQuestion alloc] initWithEntity:seed insertIntoManagedObjectContext:moc];
                [question setUid:[qd objectForKey:@"uid"]];
                [question setText:[qd objectForKey:@"text"]];
                [question setOptions:[qd objectForKey:@"options"]];
                [question setAnswers:[qd objectForKey:@"answers"]];
                [question setExplanation:[qd objectForKey:@"explanation"]];
                [moc insertObject:question];
                [result addObject:question];
                break;
            }
            case TEXT_COMPLETION: {
                TCQuestion* question = [[TCQuestion alloc] initWithEntity:tced insertIntoManagedObjectContext:moc];
                [question setUid:[qd objectForKey:@"uid"]];
                [question setText:[qd objectForKey:@"text"]];
                [question setOptions:[qd objectForKey:@"options"]];
                [question setAnswers:[qd objectForKey:@"answers"]];
                [question setExplanation:[qd objectForKey:@"explanation"]];
                [moc insertObject:question];
                [result addObject:question];
                break;
            }
            case READING_COMP: {
                NSString* text = (NSString*)[qd objectForKey:@"readText"];
                if(text != nil && ![text isEqualToString:@""]) {
                    rctext = [[RCText alloc] initWithEntity:rcted
                             insertIntoManagedObjectContext:moc];
                    rctext.text = text;
                    [moc insertObject:rctext];
                }
                RCQuestion* question = [[RCQuestion alloc] initWithEntity:rced insertIntoManagedObjectContext:moc];
                [question setText:[qd objectForKey:@"text"]];
                [question setUid:[qd objectForKey:@"uid"]];
                [question setOptions:[qd objectForKey:@"options"]];
                [question setAnswers:[qd objectForKey:@"answers"]];
                [question setExplanation:[qd objectForKey:@"explanation"]];
                [question setReadText: rctext];
                [question setMultiple: [[qd objectForKey:@"multiple"] boolValue]];
                [question setSelectSentence:[[qd objectForKey:@"selectSentence"] boolValue]];
                [moc insertObject:question];
                [result addObject:question];
                break;
            }
            default:
                break;
        }
    }
    return result;
}

@end
