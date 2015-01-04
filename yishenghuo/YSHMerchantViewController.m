//
//  YSHMerchantViewController.m
//  yishenghuo
//
//  Created by 张国俗 on 14-11-19.
//  Copyright (c) 2014年 雨轩梦蝶. All rights reserved.
//

#import "YSHMerchantViewController.h"
#import "YSHMerchantCell.h"
#import "YSHAbUserModel.h"
#import "YSHBodyModel.h"
#import "YSHSubModel.h"
#import "YSHMerchant_listModel.h"
#import "YSHYSHBodyDicModel.h"
#import "YSHAbMerchantModel.h"
#import "UIImageView+WebCache.h"



@interface YSHMerchantViewController ()<UITableViewDataSource,UITableViewDelegate
>
{
    NSArray *_contentArray;
}

@property (weak, nonatomic) IBOutlet UITableView *merchantTableView;
@end

@implementation YSHMerchantViewController

static NSString *const kCellIdentifier= @"MerchantCell";


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
    
    
    YSHAbMerchantModel *userModel = [[YSHAbMerchantModel alloc] init];
    userModel.iid = @"442816939-444075534";//@"1388992282-448288997";//128847;
    
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
//    [self merchantDetailWithUserModel:userModel];
    
}

- (void)dealloc
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreazted.
}


- (void)requestContentWithCate:(NSString *)cate
{
    YSHAbUserModel *userModel = [[YSHAbUserModel alloc] init];
    //    userModel.pcate = 0;
    userModel.cate = cate;
    [self businessListWithUserModel:userModel];

}

///10.查询商户列表接口(1010)
- (void)businessListWithUserModel:(YSHAbUserModel *)userModel
{
    NSString *json = [userModel toJSONString];
    
    __weak YSHMerchantViewController *wself = self;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:RequestAPIBaseURL parameters:[[YSHPublicClass sharePublic] RequestParameters:BusinessListCode token:nil reportXML:json] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSLog(@" responseClass=%@",NSStringFromClass(responseObject));
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"response=%@",operation.responseString);
        
        YSHMerchantViewController *swself = wself;
        if (swself == nil) {
            return ;
        }
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        YSHYSHBodyDicModel *bodyModel = [[YSHYSHBodyDicModel alloc] initWithString:operation.responseString error:nil];
        if ([bodyModel.zBODY isKindOfClass:[NSDictionary class]]) {
            
            YSHMerchant_listModel *list = [[YSHMerchant_listModel alloc] initWithDictionary:bodyModel.zBODY error:nil];
            
            
            [list.merchant_list enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
                
                YSHAbMerchantModel *abModel = [[YSHAbMerchantModel alloc] initWithDictionary:obj error:nil];
                [array addObject:abModel];
                NSLog(@"%@",abModel.id);
            }];
            swself->_contentArray = array;
            [swself.merchantTableView reloadData];
            
        }
        
        
        
    }];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YSHMerchantCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    YSHAbMerchantModel *model = _contentArray[indexPath.row];
    cell.name.text = model.name;
    cell.detail.text = model.details;
    cell.address.text = model.addr;
    [cell.nerchantImageView sd_setImageWithURL:[NSURL URLWithString:model.img_url] placeholderImage:nil];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_contentArray count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



- (void)merchantDetailWithUserModel:(YSHAbMerchantModel *)userModel
{
    NSString *json = [userModel toJSONString];
    
    __weak YSHMerchantViewController *wself = self;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:RequestAPIBaseURL parameters:[[YSHPublicClass sharePublic] RequestParameters:BusinessInfoCode token:nil reportXML:json] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSLog(@" responseClass=%@",NSStringFromClass(responseObject));
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"response=%@",operation.responseString);
        
        YSHMerchantViewController *swself = wself;
        if (swself == nil) {
            return ;
        }
        
//        NSMutableArray *array = [[NSMutableArray alloc] init];
//        YSHYSHBodyDicModel *bodyModel = [[YSHYSHBodyDicModel alloc] initWithString:operation.responseString error:nil];
//        if ([bodyModel.zBODY isKindOfClass:[NSDictionary class]]) {
//            
//            YSHMerchant_listModel *list = [[YSHMerchant_listModel alloc] initWithDictionary:bodyModel.zBODY error:nil];
//            
//            
//            [list.merchant_list enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
//                
//                YSHAbMerchantModel *abModel = [[YSHAbMerchantModel alloc] initWithDictionary:obj error:nil];
//                [array addObject:abModel];
//            }];
//            swself->_contentArray = array;
//            [swself.merchantTableView reloadData];
//            
//        }
        
        
        
    }];

}


@end
