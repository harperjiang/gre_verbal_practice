//
//  WebViewController.h
//  GRE Verbal Practice
//
//  Created by Harper on 1/2/15.
//  Copyright (c) 2015 Hao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController<UIWebViewDelegate>

@property(nonatomic) IBOutlet UIWebView* webView;

@property(nonatomic) NSString* targetURL;

@end
