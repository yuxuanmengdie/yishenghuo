//
//  YSHBodyItemModel.h
//  yishenghuo
//
//  Created by 张国俗 on 14-11-10.
//  Copyright (c) 2014年 雨轩梦蝶. All rights reserved.
//

#import "JSONModel.h"
//#import "YSHSubModel.h"
//@class YSHSubModel;

///获取栏目列表接口(1008) 第一层
@interface YSHBodyModel : JSONModel

@property (copy, nonatomic) NSString *code;
@property (copy, nonatomic) NSString *size;
@property (strong, nonatomic) NSArray *zBODY;

@end
