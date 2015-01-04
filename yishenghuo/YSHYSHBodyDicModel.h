//
//  YSHYSHBodyDicModel.h
//  yishenghuo
//
//  Created by 张国俗 on 14-11-18.
//  Copyright (c) 2014年 雨轩梦蝶. All rights reserved.
//

#import "JSONModel.h"

///10.查询商户列表接口(1010) 的第一层 dic
@interface YSHYSHBodyDicModel : JSONModel

@property (copy, nonatomic) NSString *code;
@property (copy, nonatomic) NSString *size;
@property (strong, nonatomic) NSDictionary *zBODY;

@end
