//
//  BaseModel.h
//  xcode6
//
//  Created by ZMJ on 15/3/21.
//  Copyright (c) 2015年 MJShareDemo. All rights reserved.
//
#import <JSONModel/JSONModel.h>
//#import "JSONModel.h"

@interface BaseModel : JSONModel
@property (assign, nonatomic) NSInteger status;
@property (strong, nonatomic) NSString *msg;
@property (strong, nonatomic) NSObject<ConvertOnDemand> *data;
@end

/**
 *  公共model的基类，主要是设置所有参数都是optional的，并添加序列化和反序列化方法
 */
@interface BaseDataModel : JSONModel

@end
