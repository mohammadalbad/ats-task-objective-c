//
//  PDFViewController.m
//  Task-ObjectiveC
//
//  Created by Mohammad Albadarneh on 12/18/18.
//  Copyright © 2018 Mohammad Albadarneh. All rights reserved.
//

#import "PDFViewController.h"

@interface PDFViewController ()

@end

@implementation PDFViewController

@synthesize _url, webView;

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:false animated:true];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    NSURL *url_ = [NSURL URLWithString: _url];
    [webView loadRequest: [NSURLRequest requestWithURL:url_]];
    
}


@end
