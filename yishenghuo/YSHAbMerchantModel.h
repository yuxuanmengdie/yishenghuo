//
//  YSHAbMerchantModel.h
//  yishenghuo
//
//  Created by 张国俗 on 14-11-18.
//  Copyright (c) 2014年 雨轩梦蝶. All rights reserved.
//

#import "JSONModel.h"

///10.查询商户列表接口(1010) 第三层
@interface YSHAbMerchantModel : JSONModel


@property (copy, nonatomic) NSString<Optional> *addr;
@property (copy, nonatomic) NSString<Optional> *cate;
@property (strong, nonatomic) NSNumber<Optional> *ccost;
@property (copy, nonatomic) NSString<Optional> *city;
@property (strong, nonatomic) NSNumber<Optional> *commentcount;
@property (strong, nonatomic) NSNumber<Optional> *ddist;
@property (copy, nonatomic) NSString<Optional> *details;
@property (copy, nonatomic) NSString<Optional> *id;
@property (copy, nonatomic) NSString<Optional> *iid;

@property (copy, nonatomic) NSString<Optional> *img_url;
@property (strong, nonatomic) NSNumber<Optional> *index_num;
@property (strong, nonatomic) NSNumber<Optional> *isbook;
@property (strong, nonatomic) NSNumber<Optional> *isrecommend;
@property (strong, nonatomic) NSNumber<Optional> *isupport;
@property (copy, nonatomic) NSString<Optional> *lat;
@property (copy, nonatomic) NSString<Optional> *lng;
@property (copy, nonatomic) NSString<Optional> *name;
@property (strong, nonatomic) NSNumber<Optional> *ordercount;
@property (copy, nonatomic) NSString<Optional> *rate;
@property (strong, nonatomic) NSNumber<Optional> *result_num;
@property (strong, nonatomic) NSNumber<Optional> *sort;
@property (strong, nonatomic) NSNumber<Optional> *status;
@property (copy, nonatomic) NSString<Optional> *tel;
@property (copy, nonatomic) NSString<Optional> *tgloginnum;
@property (strong, nonatomic) NSNumber<Optional> *total;
@property (copy, nonatomic) NSString<Optional> *wap_url;
@property (copy, nonatomic) NSString<Optional> *web_url;



@end
