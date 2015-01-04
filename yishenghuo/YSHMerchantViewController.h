//
//  YSHMerchantViewController.h
//  yishenghuo
//
//  Created by 张国俗 on 14-11-19.
//  Copyright (c) 2014年 雨轩梦蝶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSHMerchantViewController : UIViewController

///传入的类别
@property (copy, nonatomic) NSString *cate;


///根据类别获取数据
- (void)requestContentWithCate:(NSString *)cate;
@end
