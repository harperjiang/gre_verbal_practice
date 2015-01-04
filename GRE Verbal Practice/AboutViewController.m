//
//  AboutViewController.m
//  GRE Verbal Practice
//
//  Created by Harper on 1/1/15.
//  Copyright (c) 2015 Hao Jiang. All rights reserved.
//

#import "AboutViewController.h"
#import "UIUtils.h"
#import "WebViewController.h"

@implementation WebButton

@end

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIUtils backgroundColor];
    // Do any additional setup after loading the view.
    
    self.adSupport = [[AdBannerSupport alloc] init];
    // On iOS 6 ADBannerView introduces a new initializer, use it when available.
    if ([ADBannerView instancesRespondToSelector:@selector(initWithAdType:)]) {
        _bannerView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
    } else {
        _bannerView = [[ADBannerView alloc] init];
    }
    
    [self.adSupport setBannerView: _bannerView];
    [self.view addSubview:_bannerView];
    
    [self.adSupport setParentView: self.view];
    [self.adSupport setShrinkView: self.scrollView];
    [self.adSupport setBottomConstraint: self.bottomConstraint];
    
    // Back button
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    self.widthConstraint.constant = self.view.bounds.size.width;
}

- (void)viewDidLayoutSubviews {
    [self.adSupport layoutAnimated:NO];
}

- (void)backToMain:(id)selector {
    [UIView transitionWithView:self.navigationController.view
                      duration:0.75
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        [self.navigationController popToRootViewControllerAnimated:NO];
                    }
                    completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.destinationViewController isKindOfClass:[WebViewController class]]) {
        UIButton* button = (UIButton*)sender;
        NSString* target = [button valueForKey:@"webtarget"];
        [(WebViewController*)segue.destinationViewController setTargetURL:target];
    }
}

@end
