//
//  YSHSubModel.h
//  yishenghuo
//
//  Created by 张国俗 on 14-11-10.
//  Copyright (c) 2014年 雨轩梦蝶. All rights reserved.
//

#import "JSONModel.h"
///获取栏目列表接口(1008) 第二层
@interface YSHSubModel : JSONModel

@property (copy, nonatomic) NSString *aibangurl;
@property (strong, nonatomic) NSNumber *leve;
@property (strong, nonatomic) NSNumber *menu;
@property (copy, nonatomic) NSString *name;
@property (strong, nonatomic) NSNumber *numid;
@property (strong, nonatomic) NSNumber *parentid;
@property (strong, nonatomic) NSNumber *sort;
@property (strong, nonatomic) NSArray<Optional> *subs;

@end
