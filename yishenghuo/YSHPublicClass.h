//
//  YSHPublicClass.h
//  yishenghuo
//
//  Created by 张国俗 on 14-11-10.
//  Copyright (c) 2014年 雨轩梦蝶. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YSHAPIDef.h"

@interface YSHPublicClass : NSObject

///返回实例
+ (instancetype)sharePublic;

///返回 md5
- (NSString *)md5Str:(NSString *)oriStr;

/// 返回sign:		数据签名字段   算法:md5(手机端key+token+code+type+format)（允许没有的字段为空，但尽量有数据保证签名正确）
- (NSString *)signStrWithCode:(RequestAPICode)code token:(NSString *)token;


/// 返回请求参数  http://115.29.232.128:7888/c/app.htm?method=report&type=02&code=1008&token=&sign=7f437c82793d68283ee4763f4eb7ecbb&format=json
- (NSDictionary *)RequestParameters:(RequestAPICode)code token:(NSString *)token reportXML:(NSString *)report_xml;
@end
