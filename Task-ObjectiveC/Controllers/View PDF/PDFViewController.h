//
//  PDFViewController.h
//  Task-ObjectiveC
//
//  Created by Mohammad Albadarneh on 12/18/18.
//  Copyright © 2018 Mohammad Albadarneh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PDFViewController : UIViewController

@property (nonatomic, assign) NSString *_url;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

NS_ASSUME_NONNULL_END
