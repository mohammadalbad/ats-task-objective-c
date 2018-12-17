//
//  LoginViewController.h
//  Task-ObjectiveC
//
//  Created by Mohammad Albadarneh on 12/16/18.
//  Copyright © 2018 Mohammad Albadarneh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;

- (IBAction)Login:(id)sender;

- (void)LoginRequest:(NSString *)userNameValue withPassword: (NSString *)passwordValue;

@end

