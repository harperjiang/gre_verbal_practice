//
//  InfoDialogDelegate.m
//  GRE Verbal Master
//
//  Created by Harper on 1/31/15.
//  Copyright (c) 2015 Hao Jiang. All rights reserved.
//

#import "InfoDialogDelegate.h"
#import "InfoPresentationController.h"

@implementation InfoDialogDelegate

static InfoDialogDelegate* instance;

+ (InfoDialogDelegate *)instance {
    if(instance == nil) {
        instance = [[InfoDialogDelegate alloc] init];
    }
    return instance;
}


- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    return [[InfoPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

@end
