//
//  YSHAPIDef.h
//  yishenghuo
//
//  Created by 张国俗 on 14-11-10.
//  Copyright (c) 2014年 雨轩梦蝶. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 接口 api 的 code 的枚举
typedef NS_ENUM(NSInteger, RequestAPICode) {
    ///短信码
    ShortMessageCode = 1001,
     /// 注册
    SighUpCode = 1002,
    ///找回密码
//    FindPasswordCode = 1003,
     ///修改密码
    ChangePasswordCode = 1004,
     /// 修改用户信息
    ChangeUserInfoCode = 1005,
     /// 登录
    LoginInCode = 1006,
    /// 注销
    LoginOutCode = 1007,
    ///获取栏目列表接口
    CategaryListCode = 1008,
    ///查询商户详情接口(1009)
    BusinessInfoCode = 1009,
    ///查询商户列表接口(1010)
    BusinessListCode = 1010,
    ///查询城市商圈接口(1011)
    CityBusinessCode = 1011,
    ///模糊查询商户接口(1012)
    WildcardQueryBusinessCode = 1012,
    ///获取城市列表信息接口(1013)
    CityInfoCode = 1013,
    
};

#define RequestAPIFormat  @"json" //format:  请求报文格式  现只支持json格式数据
#define RequestAPIBaseURL @"http://115.29.232.128:7888/c/app.htm" /// 请求路径
#define RequestAPIType @"03" //type:	   终端类型 01微信 02安卓 03ios
#define  RequestAPIKey @"035a8967c0061b8" ///手机端key:安卓key: ad3925d46787fab微信key:b6055fb725df67e  ios key:035a8967c0061b8


#define KMainColor [UIColor greenColor]


@interface YSHAPIDef : NSObject

@end
