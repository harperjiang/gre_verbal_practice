//
//  InfoPresentationController.m
//  GRE Verbal Master
//
//  Created by Harper on 1/28/15.
//  Copyright (c) 2015 Hao Jiang. All rights reserved.
//

#import "InfoPresentationController.h"

@implementation InfoPresentationController


- (instancetype)initWithPresentedViewController:(UIViewController *)presented
                       presentingViewController:(UIViewController *)presenting {
    self = [super initWithPresentedViewController: presented presentingViewController: presenting];
    if(self) {
        self.dimmingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        self.dimmingView.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.5];
    }
    return self;
}

- (void)presentationTransitionWillBegin {
    self.dimmingView.frame = self.containerView.bounds;
    [self.containerView insertSubview:self.dimmingView atIndex:0];
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.dimmingView.alpha = 1.0;
    } completion:nil];
}

- (void)dismissalTransitionDidEnd:(BOOL)completed {
    [self.dimmingView removeFromSuperview];
}


- (CGRect)frameOfPresentedViewInContainerView {
    return CGRectInset(self.containerView.bounds,30,60);
}

@end
