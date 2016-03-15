//
//  EnumClass.h
//  GeneralFramework
//
//  Created by ZMJ on 15/4/19.
//  Copyright (c) 2015年 ZMJ. All rights reserved.
//

#ifndef GeneralFramework_EnumClass_h
#define GeneralFramework_EnumClass_h

typedef NS_ENUM (NSInteger, RequestType) {
    RequestTypeGET = 0,
    RequestTypePOST,
    RequestTypeUploadFile,
    RequestTypePostBodyData,
    RequestTypePostDownLoad
};

/*  图片质量
 *  高质量：原图
 *  中等质量：原图大小的70%。最小宽度：480 最大宽度：720
 *  低质量：原图大小的50%。最小宽度：320 最大宽度：480
 */
typedef NS_ENUM(NSUInteger, ImageQuality) {
    ImageQualityLow = 0,        //低质量图片
    ImageQualityNormal = 1,     //中等质量图片
    ImageQualityHigh = 2,       //高质量图片
    ImageQualityAuto = 10       //根据网络自动选择图片质量
};

typedef NS_ENUM(NSUInteger, ShareType) {
    ShareTypeWeiboSina = 0,
    ShareTypeWeiboTencent,
    ShareTypeWechatSession,     //微信好友
    ShareTypeWechatTimeline,    //微信朋友圈
    ShareTypeWechatFavorite,    //微信收藏
    ShareTypeMobileQQ,          //手机qq
    ShareTypeTGO8
};

typedef NS_ENUM(NSInteger, MoveiePlayerViewControllerMode) {
    MoviePlayerViewControllerModeNetwork = 0,
    MoviePlayerViewControllerModeLocal
    
};



///////////////////////////
typedef NS_ENUM(NSInteger, LSVideoPlayerPlaybackState) {
    LSVideoPlayerPlaybackStateStopped = 0,//播放结束状态
    LSVideoPlayerPlaybackStatePlaying,//正在播放状态
    LSVideoPlayerPlaybackStatePaused,//暂停播放状态
    LSVideoPlayerPlaybackStateFailed,//播放失败状态(视频损坏或无法识别)
};

//系列3
//赛事4
//个人2
typedef NS_ENUM(NSInteger, VIDEO_TYPE) {
    VIDEO_TYPE_HERO = 1,
    VIDEO_TYPE_PLAYER,
    VIDEO_TYPE_SERIES,
    VIDEO_TYPE_ORGNIZED,
    VIDEO_TYPE_LATEST,
};

typedef NS_ENUM (NSInteger, PayManagerType) {
    PayManagerTypeAlipay,//支付宝
    PayManagerTypeWXpay,//微信
    PayManagerTypeUppay,//银联
    PayManagerTypeMember=1,//会员卡
    PayManagerTypeNull,//空
};
#endif
