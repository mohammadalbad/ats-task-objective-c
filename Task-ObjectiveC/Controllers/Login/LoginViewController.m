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
#import "CoursesViewController.h"

@interface LoginViewController()

@end

@implementation LoginViewController

@synthesize userName, password;

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:true animated:true];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    id user = [defaults valueForKey:@"user"];
    
    if ([user length] != 0) {
        [self OpenUserCourses:NO];
    }
    
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
    
    [userName resignFirstResponder];
    [password resignFirstResponder];

    [ProgressIndicatorManger showProgressHUD];
    
    NSString *_URL = [NSString stringWithFormat:@"%@%@%@%@%@%@", HOST, LOGIN, @"?username=", userNameValue, @"&password=", passwordValue];
    
    [APIRequestManger APIRequest:_URL withBlock:^(BOOL isSuccess, NSInteger statusCode, id response) {
        
        [ProgressIndicatorManger hideProgressHUD];
        
        if (isSuccess) {
            
            NSError *error;
            NSMutableArray *json = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:&error];
            
            if ([json count] != 0) {
                
                // MARK: if you want to use the data we can by doing this :
                // NSString *FullName = json[0][@"FullName"];
                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setValue:response forKeyPath:@"user"];
                [defaults synchronize];
                
                [self OpenUserCourses:YES];
                
            } else {
                [self OpenAlert];
            }
            
        }
    }];
    
}

- (void)OpenUserCourses:(BOOL)animated
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CoursesViewController *coursesViewController = [storyboard instantiateViewControllerWithIdentifier:@"SB_CoursesViewController"];
    [self.navigationController pushViewController:coursesViewController animated:animated];
}


- (void)OpenAlert
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"Incorrect UserName or Password!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}


@end
