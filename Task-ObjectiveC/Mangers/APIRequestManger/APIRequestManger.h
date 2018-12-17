//
//  APIRequestManger.h
//  Task-ObjectiveC
//
//  Created by Mohammad Albadarneh on 12/17/18.
//  Copyright © 2018 Mohammad Albadarneh. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ResponseCompletionBlock) (BOOL isSuccess, NSInteger statusCode, id response);

@interface APIRequestManger : NSObject

+(void)APIRequest:(NSString *)_url withBlock:(ResponseCompletionBlock)_Block;

@end
