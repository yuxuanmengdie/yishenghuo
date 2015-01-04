//
//  YSHLoginVoModel.h
//  yishenghuo
//
//  Created by 张国俗 on 14-11-11.
//  Copyright (c) 2014年 雨轩梦蝶. All rights reserved.
//

#import "JSONModel.h"

@interface YSHLoginVoModel : JSONModel

@property (copy ,nonatomic) NSString *loginnum;
@property (copy ,nonatomic) NSString *phone;
@property (copy ,nonatomic) NSString *password;

@end
