//
//  YSHSendCodeVoModel.h
//  yishenghuo
//
//  Created by 张国俗 on 14-11-12.
//  Copyright (c) 2014年 雨轩梦蝶. All rights reserved.
//

#import "JSONModel.h"

@interface YSHSendCodeVoModel : JSONModel


@property (copy, nonatomic) NSString *phone;
@property (copy, nonatomic) NSString *loginnum;
@property (copy, nonatomic) NSString *type; // 01 注册 02找回密码

@property (copy, nonatomic) NSString *password;
@property (copy, nonatomic) NSString *code;
@end
