//
//  YSHBodyTestViewController.m
//  yishenghuo
//
//  Created by 张国俗 on 14-12-21.
//  Copyright (c) 2014年 雨轩梦蝶. All rights reserved.
//

#import "YSHBodyTestViewController.h"
#import "YSHBodyTestCell.h"
#import "YSHTestSectionHeadView.h"
#import "YSHTestTableHeadView.h"
#import "YSHBodyTestModel.h"
#import "YSHBodyTestResultViewController.h"

@interface YSHBodyTestViewController ()
<UITableViewDelegate,
UITableViewDataSource
>
{
    NSArray *_questionArray;
    
    NSMutableDictionary *_answerDic;
    
    int _currentQuestion;
    
    YSHBodyTestCell *_testCell;
    YSHTestTableHeadView *headView;
    
    UIButton *confirmBtn;
    
}

@property (weak, nonatomic) IBOutlet UITableView *testTableView;

@end

@implementation YSHBodyTestViewController

static NSString *const kTestCell = @"bodyTestCell";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _currentQuestion = 0;
    [self initQuestionArray];
    _answerDic = [[NSMutableDictionary alloc] init];
    [self.testTableView setDelegate:self];
    [self.testTableView setDataSource:self];
    
    UIView *hView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.testTableView.frame.size.width, 100)];
    
    headView = [[[NSBundle mainBundle] loadNibNamed:@"YSHTestTableHeadView" owner:nil options:nil] firstObject];
    
    [hView addSubview:headView];
    headView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *con1 = [NSLayoutConstraint constraintWithItem:headView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:hView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
    NSLayoutConstraint *con2 = [NSLayoutConstraint constraintWithItem:headView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:hView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *con3 = [NSLayoutConstraint constraintWithItem:headView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:hView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
     NSLayoutConstraint *con4 = [NSLayoutConstraint constraintWithItem:headView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:hView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    
    [hView addConstraints:@[con1,con2,con3,con4]];

    headView.detailLabel.preferredMaxLayoutWidth = self.testTableView.frame.size.width-16;
    [headView updateConstraintsIfNeeded];
    [headView layoutIfNeeded];
    
    CGFloat hei = [headView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
//    headView.frame = CGRectMake(0, 0, 0, 80);
//    headView.backgroundColor = [UIColor redColor];
//    headView.bounds = CGRectMake(0, 0, self.testTableView.frame.size.width,0);
   
    hView.frame = CGRectMake(0, 0, 0, hei);
    self.testTableView.tableHeaderView = hView;
    
    
    
    confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn setTitle:@"提交" forState:UIControlStateNormal];
    [confirmBtn setBackgroundImage:[publicFuncClass ImageWithColor:KMainColor] forState:UIControlStateNormal];
    confirmBtn.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    confirmBtn.enabled = NO;
    [confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    
    [confirmBtn sizeToFit];
    
    self.testTableView.tableFooterView = confirmBtn;
    
    if ([self.testTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.testTableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.testTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.testTableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
//    for (int j=0; j<[_questionArray count]; j++) {
//        int num = arc4random()%5+1;
//        NSLog(@"num=%d",num);
//        
//         [_answerDic setObject:[NSNumber numberWithInt:num] forKey:[NSString stringWithFormat:@"%d",j]];
//    }
    
    
    
//    [headView updateConstraintsIfNeeded];
//    [headView layoutIfNeeded];
   


   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    NSLog(@"%@ %@",_testTableView.tableHeaderView,headView);
}

- (void)confirmAction
{
    [self scoreResult];
}

- (void)initQuestionArray
{
    NSMutableArray *tmp = [[NSMutableArray alloc] init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"bodyTest" ofType:@"plist"];
    
    NSDictionary *dic =[NSDictionary dictionaryWithContentsOfFile:path];
    
        NSLog(@"%@",dic[@"json"]);
    NSString *str = dic[@"json"];
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//    NSArray *arr = [[JSONModel alloc] initWithString:str error:nil];
    [arr enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        YSHBodyTestModel *model = [[YSHBodyTestModel alloc] initWithDictionary:obj error:nil];
        if (_isMale && idx == 7+8+8+8+6-1) {
            
        }
        else if (!_isMale && idx == 7+8+8+8+6)
        {
            
        }
        else{
        
        
        [tmp addObject:model];
        }
    }];

    _questionArray = tmp;
}


#pragma mark datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_questionArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YSHBodyTestCell *cell = [tableView dequeueReusableCellWithIdentifier:kTestCell forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.selectSegmentControl.hidden = YES;
    cell.questionLabel.preferredMaxLayoutWidth = self.testTableView.frame.size.width-16;
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.separatorInset = UIEdgeInsetsZero;
    if (indexPath.row < _currentQuestion) {
        cell.selectSegmentControl.hidden = NO;

        NSNumber *num = _answerDic[[self keyFromIndexPath:indexPath]];
        if (num !=nil) {
             cell.selectSegmentControl.selectedSegmentIndex = [num intValue]-1;
        }
       
    }
    else if (indexPath.row == _currentQuestion) {
        NSLog(@"%d",_currentQuestion);
         cell.selectSegmentControl.hidden = NO;
         cell.selectSegmentControl.selectedSegmentIndex = UISegmentedControlNoSegment;
//        cell.contentView.backgroundColor = [UIColor redColor];
    }
    else
    {
       cell.selectSegmentControl.selectedSegmentIndex = UISegmentedControlNoSegment;
    }

 
    YSHBodyTestModel *model = _questionArray[indexPath.row];
    
    cell.questionLabel.text = model.question;
    ///  选择分数segment
    __weak typeof(self) wself = self;
    cell.segmentActionBlock = ^(int selected){
        
        __strong typeof(wself) swself = wself;
        
        if (swself == nil) {
            return ;
        }
        
        switch (selected) {
            case 0:
            case 1:
            case 2:
            case 3:
            case 4:
            {
                if ([swself->_answerDic objectForKey:[swself keyFromIndexPath:indexPath]] == nil) {
                    swself->_currentQuestion = (int)indexPath.row + 1;
                    if (swself->_currentQuestion >= [swself->_questionArray count]) {
                        NSLog(@"完成！！！");
                    }
//                    [swself.testTableView reloadData];
                    if (indexPath.row < _questionArray.count -1) {
                        
//                        [swself.testTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row+1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                        [swself.testTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row+1 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
                        
                        
                        //UITableViewRowAnimationAutomatic];
                    }
                    else
                    {
                        swself->confirmBtn.enabled = YES;
                    }
                    [swself.testTableView reloadData];
                   
                }
                else
                {
                    
                }
                [swself->_answerDic setObject:[NSNumber numberWithInt:selected+1] forKey:[swself keyFromIndexPath:indexPath]];

            }
                break;
                
            default:
                break;
        }
    };

    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    YSHTestSectionHeadView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([YSHTestSectionHeadView class]) owner:nil options:nil] firstObject];
    view.layer.masksToBounds = YES;
    view.layer.borderColor = [UIColor darkGrayColor].CGColor;
    view.layer.borderWidth = 0.5;
    __weak typeof(self) wself = self;
    view.rightBtnActionBlock = ^{
        [wself dismissViewControllerAnimated:YES completion:nil];
    };
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_testCell == nil) {
        _testCell = [tableView dequeueReusableCellWithIdentifier:kTestCell];
        
    }
    
    _testCell.bounds = CGRectMake(0, 0, self.testTableView.frame.size.width,0);
    if (indexPath.row > _currentQuestion) {
        _testCell.bottomConstraint.constant = -_testCell.selectSegmentControl.intrinsicContentSize.height+8;
    }
    else
    {
        _testCell.bottomConstraint.constant =  8;
        
    }
    YSHBodyTestModel *model = _questionArray[indexPath.row];
    
    _testCell.questionLabel.text = model.question;
    _testCell.questionLabel.preferredMaxLayoutWidth = _testCell.bounds.size.width-16;
    [_testCell.contentView updateConstraintsIfNeeded];
    [_testCell.contentView layoutIfNeeded];
    
    CGFloat height = [_testCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
//    NSLog(@"%f",height);
    return height+2;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}

#pragma mark 根据 indexPath 返回
- (NSString *)keyFromIndexPath:(NSIndexPath *)indexPath
{
    NSString *result = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return result;
}

#pragma mark 计算分数
- (void)scoreResult
{
    /// 7 8 8 8 6 7 7 7 8 每种体质题目的数目 一个9个
    /// 转化分数=[（原始分-条目数）/（条目数×4）] ×100
    
    NSArray *questionNumArr = @[@7,@8,@8,@8,@6,@7,@7,@7,@8];
    
//    NSArray *bodyType = @[@"阳虚质",@"阴虚质",@"气虚质",@"痰湿质",@"湿热质",@"血瘀质",@"特禀质",@"气郁质",@"平和质"];
    
    NSMutableArray *scoreArr = [[NSMutableArray alloc] init];
    for (int j=0; j<9; j++) {
       NSMutableArray *tmp = [@[@0,[NSNumber numberWithInt:j]] mutableCopy];
        [scoreArr addObject:tmp];
    }
    
    NSLog(@"%@dic",_answerDic);
    
    [_answerDic enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSNumber *obj, BOOL *stop) {
        int index = [key intValue];
        
        int arrIndex=0;
        if (0 <=index && index < 7) {//阳虚质
            arrIndex = 0;
           
        }
        else if (index >= 7 && index < 7+8) //阴虚质
        {
            
             arrIndex = 1;
        }
        else if (index >=7+8 && index < 7+8+8) // 气虚质
        {
           
             arrIndex = 2;
        }
        else if (index >=7+8+8 && index < 7+8+8+8) //痰湿质
        {
            arrIndex = 3;

        }
        else if (index >=7+8+8+8 && index < 7+8+8+8+6)//湿热质
        {
             arrIndex = 4;
        }
        else if (index >=7+8+8+8+6 && index < 7+8+8+8+6+7) //血瘀质
        {
            arrIndex = 5;

        }
        else if (index >=7+8+8+8+6+7 && index < 7+8+8+8+6+7+7) //特禀质
        {
             arrIndex = 6;

        }
        else if (index >=7+8+8+8+6+7+7 && index < 7+8+8+8+6+7+7+7) //气郁质
        {
            arrIndex = 7;

        }
        else if (index >=7+8+8+8+6+7+7 && index < 7+8+8+8+6+7+7+7+8) //平和质
        {
             arrIndex = 8;
        }
        
        
        NSMutableArray *sco = scoreArr[arrIndex];
        int num = [[scoreArr[arrIndex] objectAtIndex:0] intValue];
        num += [obj intValue];
        [sco setObject:[NSNumber numberWithInt:num] atIndexedSubscript:0];// = [NSNumber numberWithInt:num];

    }];
    
    
    NSLog(@"score=%@",scoreArr);

//    NSArray *array2 = [scoreArr sortedArrayUsingSelector:@selector(compare:)];
//    
//    NSLog(@"array2:%@", array2);
    
    NSMutableArray *scoreTmpArr = [scoreArr mutableCopy];
    
    [scoreTmpArr enumerateObjectsUsingBlock:^(NSArray *obj, NSUInteger idx, BOOL *stop) {
        
        NSNumber *ori = obj[0];
        
        int result = (float)([ori intValue]-[questionNumArr[idx] intValue])/([questionNumArr[idx] intValue]*4) * 100;
        
        NSMutableArray *sco = scoreArr[idx];
        [sco setObject:[NSNumber numberWithInt:result] atIndexedSubscript:0];
    }];
    

    NSArray *array2 = [scoreArr sortedArrayUsingComparator:
                       
                       ^NSComparisonResult(NSArray *obj1, NSArray *obj2) {
                           
                           // 先按照姓排序
                           
                           NSComparisonResult result = [obj1[0] compare:obj2[0]];
                           
                           // 如果有相同的姓，就比较名字
                           
                           if (result == NSOrderedSame) {
                               
                               result = [obj1[1] compare:obj2[1]];
                               
                           }  
                           
                           
                           
                           return result;  
                           
                       }];  
    
    
    
    NSLog(@"array2:%@", array2);  /// 最大的在后面
    
    _resultOriArray = scoreArr;
    _resultSortArray = [array2 mutableCopy];

    [self performSegueWithIdentifier:@"bodyTestResult" sender:self];


}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UINavigationController *nav = [segue destinationViewController];
    YSHBodyTestResultViewController *result = (YSHBodyTestResultViewController *)[nav visibleViewController];
    result.resultOriArray =  _resultOriArray;
    result.resultSortArray = _resultSortArray;
}


@end
