//
//  VocabViewController.h
//  GRE Verbal Practice
//
//  Created by Harper on 12/16/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Vocabulary.h"

@interface VocabViewController : UIViewController

@property(nonatomic, readwrite, retain) IBOutlet UILabel* wordLabel;
@property(nonatomic, readwrite, retain) IBOutlet UILabel* explanationLabel;
@property(nonatomic, readwrite, retain) IBOutlet UILabel* synonymLabel;
@property(nonatomic, readwrite, retain) IBOutlet UILabel* sampleLabel;

@property(nonatomic, readwrite, retain) IBOutlet UIButton* knowButton;
@property(nonatomic, readwrite, retain) IBOutlet UIButton* dontknowButton;
@property(nonatomic, readwrite, retain) IBOutlet UIButton* showButton;

@property(nonatomic, readwrite, retain) Vocabulary* data;

- (IBAction) buttonPressed:(id) button;

@end
