//
//  YSHAbUserModel.h
//  yishenghuo
//
//  Created by 张国俗 on 14-11-11.
//  Copyright (c) 2014年 雨轩梦蝶. All rights reserved.
//

#import "JSONModel.h"

@interface YSHAbUserModel : JSONModel

@property (copy ,nonatomic) NSString *logid; //token
 @property (assign ,nonatomic) int id;
 @property (copy ,nonatomic) NSString *loginnum;//账号
 @property (copy ,nonatomic) NSString *password;
@property (assign ,nonatomic) int type;//账户类型1普通用户2商户
 @property (copy ,nonatomic) NSString *qq;
 @property (copy ,nonatomic) NSString *phone;
 @property (copy ,nonatomic) NSString *email;
@property (assign ,nonatomic) int pcate;//父级商户分类
 @property (copy ,nonatomic) NSString *cate;//商户分类
 @property (copy ,nonatomic) NSString *image;//商户图片
// Date registertime;//注册时间
// Date lastlogintime;//上次登录
@property (assign ,nonatomic) int jifen;//账户积分
@property (assign ,nonatomic) double money;//账户金额
@property (assign ,nonatomic) int status;//账户状态0未认证1已认证2未审核
@property (assign ,nonatomic) int certificateperson;//商户认证0未认证1已认证2未审核
@property (assign ,nonatomic) int certificatecompany;//公司认证0未认证1已认证2未审核
@property (assign ,nonatomic) int certificatephone;//手机号码认证0未认证1已认证2未审核
@property (assign ,nonatomic) int certificateemail;//电子邮箱认证0未认证1已认证2未审核
 @property (copy ,nonatomic) NSString *safecode;//安全码
 @property (copy ,nonatomic) NSString *question;//注册找回 问题
 @property (copy ,nonatomic) NSString *answer;//注册找回  答案
 @property (copy ,nonatomic) NSString *certificatepersonpicy;
 @property (copy ,nonatomic) NSString *certificatepersonpicx;
 @property (copy ,nonatomic) NSString *certificatecompanypic;
@property (assign ,nonatomic) double per;
 @property (copy ,nonatomic) NSString *tgloginnum;
 @property (copy ,nonatomic) NSString *encrypt_type;

//非映射字段
 @property (copy ,nonatomic) NSString *verify_code;//校验码
 @property (copy ,nonatomic) NSString *verify_type;//校验校验类型

@end
