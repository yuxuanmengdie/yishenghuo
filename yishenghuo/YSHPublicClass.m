//
//  YSHPublicClass.m
//  yishenghuo
//
//  Created by 张国俗 on 14-11-10.
//  Copyright (c) 2014年 雨轩梦蝶. All rights reserved.
//

#import "YSHPublicClass.h"
#import <CommonCrypto/CommonDigest.h>

@implementation YSHPublicClass


+ (instancetype)sharePublic
{
    static YSHPublicClass *staPublic = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        staPublic = [[YSHPublicClass alloc] init];
    });
    return staPublic;
}

///返回 md5
- (NSString *)md5Str:(NSString *)oriStr
{
    if (oriStr == nil) {
        return nil;
    }
    
    const char *cStr = [oriStr UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
     CC_MD5( cStr, strlen(cStr), digest ); //这里的用法明显是错误的，但是不知道为什么依然可以在网络上得以流传。当srcString中包含空字符（\0）时??????????????????
//    CC_MD5( cStr, self.length, digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    
    return result;
    
}

///md5(手机端key+token+code+type+format)
- (NSString *)signStrWithCode:(RequestAPICode)code token:(NSString *)token
{
    NSString *result = nil;
    if (token == nil || token.length == 0) {
        NSString *str = [NSString stringWithFormat:@"%@%d%@%@",RequestAPIKey,code,RequestAPIType,RequestAPIFormat];
        NSLog(@"%@",str);
        result = [self md5Str:str];
    }
    else
    {
        NSString *str = [NSString stringWithFormat:@"%@%@%d%@%@",RequestAPIKey,token,code,RequestAPIType,RequestAPIFormat];
        result = [self md5Str:str];
    }
    return result;
    
}

/// 返回请求参数  http://115.29.232.128:7888/c/app.htm?method=report&type=02&code=1008&token=&sign=7f437c82793d68283ee4763f4eb7ecbb&format=json
- (NSDictionary *)RequestParameters:(RequestAPICode)code token:(NSString *)token reportXML:(NSString *)report_xml;
{
    NSString *sign = [[YSHPublicClass sharePublic] signStrWithCode:code token:token];
    
    NSMutableDictionary *para = [[NSMutableDictionary alloc] init];
    [para setObject:@"report" forKey:@"method"];
    [para setObject:RequestAPIType forKey:@"type"];
    [para setObject:[NSNumber numberWithInt:code] forKey:@"code"];
    if (sign != nil) {
        [para setObject:sign forKey:@"sign"];
    }
    if (report_xml != nil) {
        [para setObject:report_xml forKey:@"report_xml"];
    }
    [para setObject:RequestAPIFormat forKey:@"format"];
    
    return para;
    
}



@end
