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
    UIImage* yesImage = [UIImage imageNamed:@"Vocab_Yes"];
    UIImage* noImage = [UIImage imageNamed:@"Vocab_No"];
    for(VocabQuiz* quiz in self.quizSet.questions) {
        ExtendView* eview = [[ExtendView alloc] initWithFrame:CGRectMake(0,0,0,0)];
        eview.mainLabel.text = quiz.question;
        eview.explainLabel.text = [quiz.options objectAtIndex: quiz.answer - 1];
        NSInteger answer = [self.quizSet answerFor:count - 1];
        eview.imageView.image = (answer == quiz.answer)? yesImage:noImage;
        
        UIView* lineview = [[UIView alloc] initWithFrame:CGRectMake(0,0,0,0)];
        lineview.translatesAutoresizingMaskIntoConstraints = NO;
        lineview.backgroundColor = [UIColor lightGrayColor];
        
        UILabel* hiddenView = [[UILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
        hiddenView.translatesAutoresizingMaskIntoConstraints = NO;
        hiddenView.numberOfLines = 0;
//        hiddenView.backgroundColor = [UIColor lightGrayColor];
        UIFont* fontA = eview.mainLabel.font;
        UIFont* fontB = eview.explainLabel.font;
        NSMutableAttributedString* text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"This word means: %@", quiz.explanation]];
        [text addAttribute:NSFontAttributeName value:fontA range:NSMakeRange(0, 15)];
        [text addAttribute:NSFontAttributeName value:fontB range:NSMakeRange(15, text.length - 15)];
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
            // First one
            NSString *vformat = [NSString stringWithFormat: @"V:|-0-[%@]", eviewid];
            NSArray* vContainer = [NSLayoutConstraint constraintsWithVisualFormat:vformat
                                                                          options:0
                                                                          metrics:nil
                                                                            views:dict];
            [self.containerView addConstraints:vContainer];
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

- (void)viewDidLayoutSubviews {
    
    CGRect frame = self.scrollView.frame;
    NSLog(@"%f,%f,%f,%f", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    CGSize size = [self.containerView sizeThatFits:CGSizeMake(self.view.frame.size.width, 10000)];
    NSLog(@"%f,%f", size.width, size.height);
}

@end
