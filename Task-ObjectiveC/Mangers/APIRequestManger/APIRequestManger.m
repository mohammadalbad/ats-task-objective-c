//
//  APIRequestManger.m
//  Task-ObjectiveC
//
//  Created by Mohammad Albadarneh on 12/17/18.
//  Copyright © 2018 Mohammad Albadarneh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIRequestManger.h"
#import "AFNetworking.h"

@implementation APIRequestManger : NSObject

+ (void)APIRequest:(NSString *)_url withBlock:(ResponseCompletionBlock)_Block
{
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    
    [manager.requestSerializer setTimeoutInterval:60];
    [manager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"text/plain", nil];

    [manager GET:_url parameters:nil progress: nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog (@"response:%@", responseObject);
        _Block (YES, 200, responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"error:%@",error);
        _Block (NO, 400, error);
    }];
    
}

@end

