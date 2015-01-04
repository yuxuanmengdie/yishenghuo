//
//  YSHKeyMerchantModel.h
//  yishenghuo
//
//  Created by 张国俗 on 14-11-12.
//  Copyright (c) 2014年 雨轩梦蝶. All rights reserved.
//

#import "JSONModel.h"

///模糊查询商户接口(1012)
@interface YSHKeyMerchantModel : JSONModel

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *cate;
@end
