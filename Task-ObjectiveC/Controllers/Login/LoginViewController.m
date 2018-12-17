//
//  LoginViewController.m
//  Task-ObjectiveC
//
//  Created by Mohammad Albadarneh on 12/16/18.
//  Copyright © 2018 Mohammad Albadarneh. All rights reserved.
//

#import "LoginViewController.h"
#import "APIRequestManger.h"
#import "UtilityAPIHost.h"
#import "ProgressIndicatorManger.h"

@interface LoginViewController()

@end

@implementation LoginViewController

@synthesize userName, password;


- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:true animated:true];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)Login:(id)sender {
    
    NSString *userNameValue = userName.text;
    if([userNameValue length] == 0) {
        [userName becomeFirstResponder];
        return;
    }
    
    NSString *passwordValue = password.text;
    if([passwordValue length] == 0) {
        [password becomeFirstResponder];
        return;
    }
    
    [self LoginRequest:userNameValue withPassword:passwordValue];
    
}

- (void)LoginRequest:(NSString *)userNameValue withPassword:(NSString *)passwordValue
{
    
    [ProgressIndicatorManger showProgressHUD];
    
    NSString *_URL = [NSString stringWithFormat:@"%@%@%@%@%@%@", HOST, LOGIN, @"?username=", userNameValue, @"&password=", passwordValue];
    
    [APIRequestManger APIRequest:_URL withBlock:^(BOOL isSuccess, NSInteger statusCode, id response) {
       
        [ProgressIndicatorManger hideProgressHUD];

        if (isSuccess) {
            
            NSError *error;
            NSMutableArray *json = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:&error];

            if ([json count] != 0) {
                
                NSString *ID = json[0][@"ID"];
                NSString *FullName = json[0][@"FullName"];
                NSString *Password = json[0][@"Password"];
                NSString *UserName = json[0][@"UserName"];
                
            }
            
        }
    }];
    
    
    
}

@end
