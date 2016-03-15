//
//  TSEHttpTool.h
//  XCAR
//
//  Created by Morris on 10/2/15.
//  Copyright © 2015 Samtse. All rights reserved.
//

#import "TSEHttpTool.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"

@implementation TSEHttpTool

+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure

{
    
    // 1.创建请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    [mgr.requestSerializer setValue:@"89fe7f6a98987018fa22a97f3bf7c10d" forHTTPHeaderField:@"apikey"];
    // 2.发送请求
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (failure) {
            failure(error);
        }
        
    }];
}

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    // 1.创建请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.发送请求
    [mgr POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
}
+ (void)saveGuardPlanWithString:(NSString *)GuardPlan{
    NSUserDefaults *info=[NSUserDefaults standardUserDefaults];
    [info setObject:GuardPlan forKey:@"GuardPlan"];
    [info synchronize];
}
+ (NSString *)getGuardPlan{
    NSUserDefaults *info=[NSUserDefaults standardUserDefaults];
    return [info objectForKey:@"GuardPlan"];
}

@end
