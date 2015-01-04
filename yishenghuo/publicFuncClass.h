//
//  publicFuncClass.h
//  yishenghuo
//
//  Created by mac on 15-1-4.
//  Copyright (c) 2015年 雨轩梦蝶. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface publicFuncClass : NSObject


//添加不要备份属性
+ (BOOL)addSkipBAckupAttributeItemAtURL:(NSURL *)URL;

/// 修改图片尺寸
+ (UIImage *)TransformWithImage:(UIImage *)oriImage toSize:(CGSize)Newsize;


///用color画图 默认为 wid=1 hei=
+ (UIImage *) ImageWithColor: (UIColor *) color;

+ (UIImage *) ImageWithColor: (UIColor *) color frame:(CGRect)aFrame;

///判断是否为邮箱格式
+ (BOOL)isEmaliRegex:(NSString *)email;

/// 键盘顶部添加隐藏栏
+ (void)addHiddenItemOnkeyboardWithView:(UIView *)Responder delegate:(id)delegate sel:(SEL)method;


@end
