//
//  YSHBodyTestResultViewController.m
//  yishenghuo
//
//  Created by 张国俗 on 15-1-5.
//  Copyright (c) 2015年 雨轩梦蝶. All rights reserved.
//

#import "YSHBodyTestResultViewController.h"

@interface YSHBodyTestResultViewController ()
{
    /// 是
    int sureType;
    ///可能是
    int maySureType;
    /// 倾向
    NSMutableArray *tendency;
}

@end

/*
 平和质
 转化分≧60分
 是
 其他8种体质转化分均﹤30分
 转化分≧60分
 基本是
 其他8种体质转化分均﹤40分
 不满足上述条件者
 否
 偏颇体质
 转化分≧40分
 是
 转化分30~39分
 倾向是
 转化分﹤30分
 否

 
 */
@implementation YSHBodyTestResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
