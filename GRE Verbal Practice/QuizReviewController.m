//
//  QuizReviewController.m
//  GRE Verbal Master
//
//  Created by Harper on 1/31/15.
//  Copyright (c) 2015 Hao Jiang. All rights reserved.
//

#import "QuizReviewController.h"
#import "UIUtils.h"
#import "ExtendView.h"

@interface QuizReviewController ()

@end

@implementation QuizReviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIUtils backgroundColor];
    
    NSInteger count = 1;
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    /*ExtendView* ev = [[ExtendView alloc] initWithFrame:CGRectMake(0,0,0,0)];
    ev.mainLabel.text = @"This is a first Label";
    [dict setObject:ev forKey:@"ev"];
    [self.containerView addSubview:ev];
    
    UIView* lineview = [[UIView alloc] initWithFrame:CGRectMake(0,0,0,0)];
    lineview.translatesAutoresizingMaskIntoConstraints = NO;
    lineview.backgroundColor = [UIColor lightGrayColor];
    [dict setObject:lineview forKey:@"lv"];
    [self.containerView addSubview:lineview];
    
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[ev(==900)]-0-[lv(==1)]-0-|" options:0 metrics:nil views:dict]];
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[ev]-0-|" options:0 metrics:nil views:dict]];
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[lv]-0-|" options:0 metrics:nil views:dict]];
    */
   
    for(VocabQuiz* quiz in self.quizSet.questions) {
        ExtendView* eview = [[ExtendView alloc] initWithFrame:CGRectMake(0,0,0,0)];
        eview.mainLabel.text = quiz.question;
        
        NSDictionary* answers = quiz.answerInfo;
        NSString* youranswer = [answers objectForKey:@"user"];
        NSString* correctAnswer = [answers objectForKey:@"answer"];
        eview.answerLabel.text = youranswer;
        eview.correctLabel.text = [NSString stringWithFormat:@"Correct answer:%@", correctAnswer];
        [eview setMode:(quiz.userAnswer == quiz.answer)];
        
        UIView* lineview = [[UIView alloc] initWithFrame:CGRectMake(0,0,0,0)];
        lineview.translatesAutoresizingMaskIntoConstraints = NO;
        lineview.backgroundColor = [UIColor lightGrayColor];
        
        UILabel* hiddenView = [[UILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
        hiddenView.translatesAutoresizingMaskIntoConstraints = NO;
        hiddenView.numberOfLines = 0;
        
        UIFont* fontB = eview.mainLabel.font;
        UIFont* fontA = [UIFont fontWithName:@"Verdana-Bold" size:13];

        
        NSString* plainString = [NSString stringWithFormat:@"This word means: %@", quiz.explanation];
        NSMutableAttributedString* text = [[NSMutableAttributedString alloc] initWithString: plainString];
        [text addAttribute:NSFontAttributeName value:fontA range:NSMakeRange(0, 17)];
        [text addAttribute:NSFontAttributeName value:fontB range:NSMakeRange(17, text.length - 17)];
        hiddenView.attributedText = text;
        
        eview.extendView = hiddenView;
        
        NSString* eviewid = [NSString stringWithFormat:@"eview%zd",count];
        NSString* lineviewid = [NSString stringWithFormat:@"lineview%zd",count];
        
        [dict setObject:eview forKey:eviewid];
        [dict setObject:lineview forKey:lineviewid];
        
        [self.containerView addSubview:eview];
        [self.containerView addSubview:lineview];
        
        // Add H Constraint
        NSString* hformat = [NSString stringWithFormat: @"|-0-[%@]-0-|", eviewid];
        NSArray* hContainer = [NSLayoutConstraint constraintsWithVisualFormat:hformat
                                                                      options:0
                                                                      metrics:nil
                                                                        views:dict];
        [self.containerView addConstraints:hContainer];
        
        NSString* hformat2 = [NSString stringWithFormat: @"|-0-[%@]-0-|", lineviewid];
        NSArray* hContainer2 = [NSLayoutConstraint constraintsWithVisualFormat:hformat2
                                                                       options:0
                                                                       metrics:nil
                                                                         views:dict];
        [self.containerView addConstraints:hContainer2];
    
        // Add V constraint
        
        NSString *vattach = [NSString stringWithFormat: @"V:[eview%zd]-0-[lineview%zd(==1)]", count, count];
        NSArray* vac = [NSLayoutConstraint constraintsWithVisualFormat:vattach
                                                               options:0
                                                               metrics:nil
                                                                 views:dict];
        [self.containerView addConstraints:vac];
        
        if(count == 1) {
            UIView* lineview0 = [[UIView alloc] initWithFrame:CGRectMake(0,0,0,0)];
            lineview0.translatesAutoresizingMaskIntoConstraints = NO;
            lineview0.backgroundColor = [UIColor lightGrayColor];
            [dict setObject:lineview0 forKey:@"lineview0"];
            
            [self.containerView addSubview:lineview0];
            NSString *vformat = @"V:|-0-[lineview0(==1)]-0-[eview1]";
            NSArray* vContainer = [NSLayoutConstraint constraintsWithVisualFormat:vformat
                                                                          options:0
                                                                          metrics:nil
                                                                            views:dict];
            [self.containerView addConstraints:vContainer];
            
            NSString* hlvformat = @"|-0-[lineview0]-0-|";
            NSArray* hlvContainer = [NSLayoutConstraint constraintsWithVisualFormat:hlvformat
                                                                           options:0
                                                                           metrics:nil
                                                                             views:dict];
            [self.containerView addConstraints:hlvContainer];
            
        } else if(count == self.quizSet.size) {
            // Last one
            NSString *vformat = [NSString stringWithFormat: @"V:[%@]-0-|", lineviewid];
            NSArray* vContainer = [NSLayoutConstraint constraintsWithVisualFormat:vformat
                                                                          options:0
                                                                          metrics:nil
                                                                            views:dict];
            [self.containerView addConstraints:vContainer];
        }
        if(count > 1) {
            // Those in the middle
            NSString *vformat = [NSString stringWithFormat: @"V:[lineview%zd]-0-[%@]", count - 1, eviewid];
            NSArray* vContainer = [NSLayoutConstraint constraintsWithVisualFormat:vformat
                                                                          options:0
                                                                          metrics:nil
                                                                            views:dict];
            [self.containerView addConstraints:vContainer];
        }
        count += 1;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    // Set Width Constraint
    self.containerWidth.constant = self.view.bounds.size.width;
}

- (void)shouldShrink:(NSInteger)bottomdist {
    self.adBottomConstraint.constant = bottomdist;
}

@end
