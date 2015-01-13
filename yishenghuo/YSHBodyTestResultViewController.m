//
//  YSHBodyTestResultViewController.m
//  yishenghuo
//
//  Created by 张国俗 on 15-1-5.
//  Copyright (c) 2015年 雨轩梦蝶. All rights reserved.
//

#import "YSHBodyTestResultViewController.h"
#import "YSHBodyTestChartView.h"
#import "YSHTagLabelView.h"

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
    
    /// 主体质
    NSString *_bodyType;
}

@property (weak, nonatomic) IBOutlet UIScrollView *backScrollView;

@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet UILabel *titleTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *moreTypeLabel;

@property (weak, nonatomic) IBOutlet YSHBodyTestChartView *chartView;
@property (weak, nonatomic) IBOutlet YSHTagLabelView *detail1;
@property (weak, nonatomic) IBOutlet YSHTagLabelView *detail2;
@property (weak, nonatomic) IBOutlet YSHTagLabelView *detail3;
@property (weak, nonatomic) IBOutlet YSHTagLabelView *detail4;
@property (weak, nonatomic) IBOutlet YSHTagLabelView *detail5;
@property (weak, nonatomic) IBOutlet YSHTagLabelView *detail6;




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
    
    
    [[UINavigationBar appearance] setBarTintColor:KMainColor];
    self.title = @"你大爷";
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(returnBack) forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = left;
    
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    NSArray *bodyType = @[@"阳虚质",@"阴虚质",@"气虚质",@"痰湿质",@"湿热质",@"血瘀质",@"特禀质",@"气郁质",@"平和质"];
    _bodyTypeArray = bodyType;
    [self testResult];
    
    
    _moreTypeLabel.text = [self resultShow];
    
    int idx;
    if (type == 1 || type == 2) {
        idx = (int)bodyType.count-1;
    }
    else
    {
        NSNumber *idxNUm = [_resultSortArray lastObject][1];
        idx = [idxNUm intValue];

    }
    _titleTypeLabel.text = _bodyType;
    _titleTypeLabel.textColor = KMainColor;
    
    _detail1.translatesAutoresizingMaskIntoConstraints = NO;
    _detail2.translatesAutoresizingMaskIntoConstraints = NO;
    _detail3.translatesAutoresizingMaskIntoConstraints = NO;
    _detail4.translatesAutoresizingMaskIntoConstraints = NO;
    _detail5.translatesAutoresizingMaskIntoConstraints = NO;
    _detail6.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"bodyType" ofType:@"plist"];
    NSArray *detailArray = [NSArray arrayWithContentsOfFile:path];
    _detail1.textLabel.text = detailArray[idx][0];
    _detail2.textLabel.text = detailArray[idx][1];
    _detail3.textLabel.text = detailArray[idx][2];
    _detail4.textLabel.text = detailArray[idx][3];
    _detail5.textLabel.text = detailArray[idx][4];
    _detail6.textLabel.text = detailArray[idx][5];
    
    _backScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    _backView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *wid = [NSLayoutConstraint constraintWithItem:_backView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
//    NSLayoutConstraint *hei = [NSLayoutConstraint constraintWithItem:_backView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    [self.view addConstraint:wid];
    
    [_detail1 updateConstraintsIfNeeded];
    [_detail1 layoutIfNeeded];
    [_detail2 layoutIfNeeded];
    [_detail3 layoutIfNeeded];
    [_detail4 layoutIfNeeded];
    [_detail5 layoutIfNeeded];
    [_detail6 layoutIfNeeded];
    float detailHeight = [_detail1 systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    NSLog(@"detailHeight=%f",detailHeight);
    NSLayoutConstraint *detailHei1 = [NSLayoutConstraint constraintWithItem:_detail1 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:detailHeight];
    
    detailHeight = [_detail2 systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    NSLog(@"detailHeight=%f",detailHeight);
    
    NSLayoutConstraint *detailHei2 = [NSLayoutConstraint constraintWithItem:_detail2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:detailHeight];
    
    detailHeight = [_detail3 systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    NSLayoutConstraint *detailHei3 = [NSLayoutConstraint constraintWithItem:_detail3 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:detailHeight];
    NSLog(@"detailHeight=%f",detailHeight);
    detailHeight = [_detail4 systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    NSLog(@"detailHeight=%f",detailHeight);
    NSLayoutConstraint *detailHei4 = [NSLayoutConstraint constraintWithItem:_detail4 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:detailHeight];
    detailHeight = [_detail5 systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    NSLog(@"detailHeight=%f",detailHeight);
    NSLayoutConstraint *detailHei5 = [NSLayoutConstraint constraintWithItem:_detail5 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:detailHeight];
    detailHeight = [_detail6 systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    NSLog(@"detailHeight=%f",detailHeight);
    NSLayoutConstraint *detailHei6 = [NSLayoutConstraint constraintWithItem:_detail6 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:detailHeight];
    NSLog(@"detailHeight=%f",detailHeight);
    [self.backView addConstraints:@[detailHei1,detailHei2,detailHei3,detailHei4,detailHei5,detailHei6]];
    
    [self.backView updateConstraintsIfNeeded];
    [self.backView layoutIfNeeded];
    
    
    _chartView.translatesAutoresizingMaskIntoConstraints = NO;
    [_chartView layoutIfNeeded];
    CGSize chartSize = [_chartView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    NSArray *cons  = @[_chartView.topConstraint1,_chartView.topConstraint2,_chartView.topConstraint3,_chartView.topConstraint4,_chartView.topConstraint5,_chartView.topConstraint6,_chartView.topConstraint7,_chartView.topConstraint8];
    
    NSArray *viewArr = @[_chartView.typeView1,_chartView.typeView2,_chartView.typeView3,_chartView.typeView4,_chartView.typeView5,_chartView.typeView6,_chartView.typeView7,_chartView.typeView8];
    
    
    NSNumber *num = [_resultSortArray lastObject][0];
    int hight = [num intValue];
    _chartView.hightScore = hight;
    for (int j=0; j<_resultOriArray.count-1; j++) {
        if (j<cons.count) {
            
            NSNumber *idxNUm = _resultOriArray[j][0];
            int score = [idxNUm intValue];
            
            NSLayoutConstraint *con  = cons[j];
            if (hight == 0) {
                con.constant = 0;
            }
            else
            {
                con.constant = (1-(float)score/hight)*chartSize.height;
            }
             UIView *typeView = viewArr[j];
            typeView.backgroundColor = KMainColor;
            
            if (j==idx) {
               
                typeView.backgroundColor = [UIColor orangeColor];
            }

        }
    }
    [_chartView setNeedsDisplay];
    [_chartView layoutIfNeeded];
    
    
    
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


- (void)returnBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _moreTypeLabel.preferredMaxLayoutWidth = CGRectGetWidth(_moreTypeLabel.frame);
    
    [self.backView updateConstraintsIfNeeded];
    [self.backView layoutIfNeeded];
    float backViewHei = [self.backView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    NSLayoutConstraint *backCon = [NSLayoutConstraint constraintWithItem:self.backView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:backViewHei];
    [self.backView addConstraint:backCon];
}

#pragma mark
//- (void)chartView
//{
//    
//}



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
        _bodyType = @"平和质";
    }
    else if ([num intValue] < 40) /// 基本平和质
    {
        type = 2;
        _bodyType = @"基本平和质";
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
        NSNumber *idxNUm = [tmp lastObject][1];
        int idx = [idxNUm intValue];
        _bodyType = _bodyTypeArray[idx];
        
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
    
    NSString *result = nil;
    if (type == 1) {
        
        NSLog(@"平和质");
    
    }
    else if (type == 2)
    {
        NSLog(@"基本平和质");
        
        if (_showArray.count > 0)
        {
            result = @"倾向";
        }
        
        for (NSInteger j=0; j<[_showArray count]; j++) {
            
            NSArray *arr = _showArray[j];
            int idx = [arr[1] intValue];
            
            if (j < [_showArray count]-1) {
                result = [result stringByAppendingString:[ NSString stringWithFormat:@"%@、",_bodyTypeArray[idx] ]];
            }
            else
            {
                result = [result stringByAppendingString:[ NSString stringWithFormat:@"%@。",_bodyTypeArray[idx] ]];
            }
            
            
        }

        
    }
    else //偏颇体质
    {
        for (NSInteger j=1; j<[_showArray count]; j++) {
            
            NSArray *arr = _showArray[j];
            int score = [arr[0] intValue];
            int idx = [arr[1] intValue];
            static BOOL isfirst = YES;
            if (score >= 40) { /// 兼有
                
                if (isfirst) {
                    isfirst = NO;
                    result = @"兼有";
                }
                if (j < [_showArray count]-1) {
                  result = [result stringByAppendingString:[ NSString stringWithFormat:@"%@、",_bodyTypeArray[idx] ]];
                }
                else
                {
                    result = [result stringByAppendingString:[ NSString stringWithFormat:@"%@。",_bodyTypeArray[idx] ]];
                }

            }
            else
            {
                static BOOL first = YES;
                if (first) {
                    first = NO;
                    if (isfirst) {
                        result = [result stringByAppendingString:@"倾向"];//[ NSString stringWithFormat:@"%@。",_bodyTypeArray[idx] ]];
                    }
                    else
                    {
//                    result = @"。\n\n倾向";
                        result = [result substringToIndex:result.length-1];
                        result = [result stringByAppendingString:[ NSString stringWithFormat:@"。\n\n倾向"]];
                    }
                }
                if (j < [_showArray count]-1) {
                    result = [result stringByAppendingString:[ NSString stringWithFormat:@"%@、",_bodyTypeArray[idx] ]];
                }
                else
                {
                    result = [result stringByAppendingString:[ NSString stringWithFormat:@"%@。",_bodyTypeArray[idx] ]];
                }


            }
            
            
        }

        
    }
    
    return result;
}
@end
