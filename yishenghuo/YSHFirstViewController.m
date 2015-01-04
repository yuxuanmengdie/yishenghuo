//
//  YSHFirstViewController.m
//  yishenghuo
//
//  Created by 张国俗 on 14-11-17.
//  Copyright (c) 2014年 雨轩梦蝶. All rights reserved.
//

#import "YSHFirstViewController.h"
#import "YSHFirstCollectionViewCell.h"
#import "YSHCategaryListView.h"
#import "YSHAbUserModel.h"
#import "YSHBodyModel.h"
#import "YSHSubModel.h"
#import "YSHMerchant_listModel.h"
#import "YSHYSHBodyDicModel.h"
#import "YSHAbMerchantModel.h"
#import "YSHMerchantViewController.h"

@interface YSHFirstViewController ()<UICollectionViewDataSource,
UICollectionViewDelegate>
{
    ///保存种类的数组
    NSArray *_categaryArray;
    
    ///最后点击的
    NSIndexPath *_lastSelected;
}

@property (weak, nonatomic) IBOutlet UICollectionView *categaryCollectionView;
@end

static NSString *const kCollectionCellIdetifier = @"firstCollectionCell";

@implementation YSHFirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)awakeFromNib
{
    [self categaryListWithUserModel:nil];
    
    YSHAbUserModel *userModel = [[YSHAbUserModel alloc] init];
//    userModel.pcate = 0;
    userModel.cate = @"美食";
//    [self businessListWithUserModel:userModel];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 获取类别数据
///获取栏目列表接口(1008)
- (void)categaryListWithUserModel:(YSHAbUserModel *)userModel
{
    NSString *json = [userModel toJSONString];
    
    __weak YSHFirstViewController *wself = self;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:RequestAPIBaseURL parameters:[[YSHPublicClass sharePublic] RequestParameters:CategaryListCode token:nil reportXML:json] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSLog(@" responseClass=%@",NSStringFromClass(responseObject));
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"response=%@",operation.responseString);
        
        YSHFirstViewController *swself = wself;
        
        if (swself == nil) {
            return ;
        }
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        YSHBodyModel *bodyModel = [[YSHBodyModel alloc] initWithString:operation.responseString error:nil];
        if ([bodyModel.zBODY isKindOfClass:[NSArray class]]) {
            
            [bodyModel.zBODY enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
                
                YSHSubModel *sub = [[YSHSubModel alloc] initWithDictionary:obj error:nil];
                [array addObject:sub];
            }];
            
            swself->_categaryArray = array;
            [swself.categaryCollectionView reloadData];

        }
        
        
    }];
    
}

///10.查询商户列表接口(1010)
- (void)businessListWithUserModel:(YSHAbUserModel *)userModel
{
    NSString *json = [userModel toJSONString];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:RequestAPIBaseURL parameters:[[YSHPublicClass sharePublic] RequestParameters:BusinessListCode token:nil reportXML:json] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSLog(@" responseClass=%@",NSStringFromClass(responseObject));
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"response=%@",operation.responseString);
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        YSHYSHBodyDicModel *bodyModel = [[YSHYSHBodyDicModel alloc] initWithString:operation.responseString error:nil];
        if ([bodyModel.zBODY isKindOfClass:[NSDictionary class]]) {
            
            YSHMerchant_listModel *list = [[YSHMerchant_listModel alloc] initWithDictionary:bodyModel.zBODY error:nil];
            
            
            [list.merchant_list enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
                
                YSHAbMerchantModel *abModel = [[YSHAbMerchantModel alloc] initWithDictionary:obj error:nil];
                [array addObject:abModel];
            }];
            
            
        }

        
        
    }];
    
}



#pragma mark collectionView dataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YSHFirstCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionCellIdetifier forIndexPath:indexPath];
    YSHSubModel *subModel = _categaryArray[indexPath.row];
    cell.titleLabel.text = subModel.name;
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_categaryArray count];
}


#pragma mark collectionView delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _lastSelected = indexPath;
    [self performSegueWithIdentifier:@"merchant" sender:self];
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    YSHMerchantViewController *merchantViewController = segue.destinationViewController;
    if (_lastSelected.row >= 0 && _lastSelected.row < [_categaryArray count]) {
     
        YSHSubModel *model = _categaryArray[_lastSelected.row];
        [merchantViewController requestContentWithCate:model.name];

    }
    
}

@end
