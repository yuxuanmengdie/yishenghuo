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
    
    UIView *hView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 100)];
    
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
    self.testTableView.tableFooterView = nil;
    
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
        [tmp addObject:model];
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
                        [swself.testTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row+1 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
                        
                        
                         [swself.testTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row+1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
                    }
                   
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
    NSLog(@"%f",height);
    return height+2;
}

#pragma mark 根据 indexPath 返回
- (NSString *)keyFromIndexPath:(NSIndexPath *)indexPath
{
    NSString *result = [NSString stringWithFormat:@"%d",indexPath.row];
    return result;
}



@end
