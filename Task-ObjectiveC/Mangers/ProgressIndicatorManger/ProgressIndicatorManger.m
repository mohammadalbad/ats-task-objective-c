//
//  ProgressIndicatorManger.m
//  Task-ObjectiveC
//
//  Created by Mohammad Albadarneh on 12/17/18.
//  Copyright © 2018 Mohammad Albadarneh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "ProgressIndicatorManger.h"

@implementation ProgressIndicatorManger : NSObject

+ (void)showProgressHUD
{
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    [MBProgressHUD showHUDAddedTo:window animated:YES];
}

+ (void)hideProgressHUD
{
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    [MBProgressHUD hideHUDForView:window animated:YES];
}

@end

