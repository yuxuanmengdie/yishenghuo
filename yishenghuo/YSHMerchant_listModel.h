//
//  YSHMerchant_listModel.h
//  yishenghuo
//
//  Created by 张国俗 on 14-11-18.
//  Copyright (c) 2014年 雨轩梦蝶. All rights reserved.
//

#import "JSONModel.h"

///10.查询商户列表接口(1010) 的第二层 dic
@interface YSHMerchant_listModel : JSONModel

@property (copy, nonatomic) NSString *count_no;
@property (strong ,nonatomic) NSArray *merchant_list;
@property (strong, nonatomic) NSNumber *size;

@end
