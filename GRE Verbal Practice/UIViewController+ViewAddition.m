//
//  UIViewController+ViewAddition.m
//  GRE Verbal Master
//
//  Created by Harper on 2/5/15.
//  Copyright (c) 2015 Hao Jiang. All rights reserved.
//

#import "UIViewController+ViewAddition.h"

@implementation UIViewController (ViewAddition)

- (BOOL)isPad {
#ifdef UI_USER_INTERFACE_IDIOM
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
#else
    return NO;
#endif
}


@end
