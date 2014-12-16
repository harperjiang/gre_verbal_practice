//
//  VocabViewController.m
//  GRE Verbal Practice
//
//  Created by Harper on 12/16/14.
//  Copyright (c) 2014 Hao Jiang. All rights reserved.
//

#import "VocabViewController.h"

@interface VocabViewController ()

@end

@implementation VocabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) setData:(Vocabulary *)data {
    self->_data = data;
    
    [self.wordLabel setText:data.word];
    [self.explanationLabel setText: data.explanation];
    [self.synonymLabel setText: data.synonyms];
    [self.sampleLabel setText:data.samples];
}

- (void) buttonPressed:(id) button {
    
    if(button == self.showButton) {
        [self modeAnswer];
    }
    
    if(button == self.knowButton || button == self.dontknowButton) {
        [self modeQuestion];
    }
}

- (void)modeQuestion {
    [self.explanationLabel setHidden:true];
    [self.knowButton setHidden:true];
    [self.dontknowButton setHidden:true];
    [self.showButton setHidden:false];
}

- (void)modeAnswer {
    [self.explanationLabel setHidden:false];
    [self.knowButton setHidden:false];
    [self.dontknowButton setHidden:false];
    [self.showButton setHidden:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
