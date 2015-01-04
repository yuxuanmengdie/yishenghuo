//
//  YSHBodyTestModel.h
//  yishenghuo
//
//  Created by 张国俗 on 14-12-23.
//  Copyright (c) 2014年 雨轩梦蝶. All rights reserved.
//

#import "JSONModel.h"

/**  身体检查的数据 model*/
@interface YSHBodyTestModel : JSONModel

/** 体质类型 如平和质，肾虚质*/
@property (assign, nonatomic) int bodyID;

@property (assign, nonatomic) long id;

@property (assign, nonatomic) int isLine;

@property (copy, nonatomic) NSString *question;

@end
