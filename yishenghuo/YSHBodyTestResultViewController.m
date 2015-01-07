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
    
    /// 体质 1为平和质 2为基本平和质， 3为其他
    int type;
    
    ///保存要展示的体质数组
    NSArray *_showArray;
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


- (void)testResult
{
    
    NSMutableArray *tmp = [_resultSortArray mutableCopy];
    
    [_resultSortArray enumerateObjectsUsingBlock:^(NSArray *obj, NSUInteger idx, BOOL *stop) {
        
        if ([obj[1] intValue] == [_resultSortArray count]-1) {
            [tmp removeObjectAtIndex:idx];
            *stop = YES;
        }
        
    }];
    
    NSNumber *num = [tmp lastObject][0];
    
    
    NSMutableArray *showArr = [[NSMutableArray alloc] init];

    if ([num intValue] < 30) { /// 平和质
        type = 1;
        
    }
    else if ([num intValue] < 40) /// 基本平和质
    {
        type = 2;
        [showArr addObject:[tmp lastObject]];
        for (NSInteger j=[tmp count]-2; j>=0; j--) {
            
            NSArray *arr = tmp[j];
            int score = [arr[0] intValue];
            
            if (score >= 30) {
                [showArr addObject:arr];
            }
        }
    }
    else
    {
        type = 3;
        
        [showArr addObject:[tmp lastObject]];
        for (NSInteger j=[tmp count]-2; j>=0; j--) {
            
            NSArray *arr = tmp[j];
            int score = [arr[0] intValue];
            
            if (score >= 30) {
                [showArr addObject:arr];
            }
        }

    }
    _showArray = showArr;
    
}



- (NSString *)resultShow
{
    if (type == 1) {
        
        NSLog(@"平和质");
    }
    else if (type == 2)
    {
        NSLog(@"基本平和质");
    }
    else
    {
        
    }
    
    return nil;
}
@end
