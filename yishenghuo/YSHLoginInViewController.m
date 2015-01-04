//
//  YSHLoginInViewController.m
//  yishenghuo
//
//  Created by 张国俗 on 14-11-11.
//  Copyright (c) 2014年 雨轩梦蝶. All rights reserved.
//

#import "YSHLoginInViewController.h"
#import "YSHLoginVoModel.h"
#import "YSHSendCodeVoModel.h"
#import "YSHAbUserModel.h"
#import "YSHCityVoModel.h"

@interface YSHLoginInViewController ()

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIView *sepView1;
@property (weak, nonatomic) IBOutlet UIView *sepView2;
@property (weak, nonatomic) IBOutlet UIButton *loginInButton;
@property (weak, nonatomic) IBOutlet UIButton *singUpButton;
@property (weak, nonatomic) IBOutlet UIButton *fastLoginButton;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *findPasswordBarItem;

- (IBAction)loginInAction:(id)sender;
- (IBAction)signUpAction:(id)sender;
- (IBAction)fastLoginAction:(id)sender;
- (IBAction)findPasswordAction:(id)sender;
@end

@implementation YSHLoginInViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginInAction:(id)sender {
    
    YSHLoginVoModel *login = [[YSHLoginVoModel alloc] init];
//    login.phone = @"";
//    login.password = @"12345zzxxcc";
//    login.loginnum = @"zhengshengh";
//    login.password = @"qwe123456";
//    login.loginnum = @"zhangguo";
    
    login.password = _passwordTextField.text;
    login.loginnum = _userNameTextField.text; ///登录为注册的手机号，不是用户名

    NSString *json = [login toJSONString];
    NSLog(@"%@",json);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:RequestAPIBaseURL parameters:[[YSHPublicClass sharePublic] RequestParameters:LoginInCode token:nil reportXML:json] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        //        NSLog(@" responseClass=%@",NSStringFromClass(responseObject));
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"response=%@",operation.responseString);
        
        
    }];

}

- (IBAction)signUpAction:(id)sender {
}

- (IBAction)fastLoginAction:(id)sender {
}

/// 找回密码 获取验证码
- (IBAction)findPasswordAction:(id)sender {
    
    YSHSendCodeVoModel *send = [[YSHSendCodeVoModel alloc] init];
    send.phone = @"18559912772";
    send.type = @"02"; 
    send.loginnum = @"zhangguo";
    
    NSString *code = [send toJSONString]; //ok
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:RequestAPIBaseURL parameters:[[YSHPublicClass sharePublic] RequestParameters:ShortMessageCode token:nil reportXML:code] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSLog(@" responseClass=%@",NSStringFromClass(responseObject));
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"response=%@",operation.responseString);
        
        
    }];

    
}

/// 验证验证码
- (void)verifyCodeWithCodeModel:(YSHSendCodeVoModel *)send
{
//    YSHSendCodeVoModel *send = [[YSHSendCodeVoModel alloc] init];
//    send.phone = @"18559912772";
//    send.type = @"02";
//    send.loginnum = @"zhangguo";
//    send.code = code;
//    send.password =
//    
    NSString *json = [send toJSONString]; //ok
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:RequestAPIBaseURL parameters:[[YSHPublicClass sharePublic] RequestParameters:ShortMessageCode token:nil reportXML:json] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSLog(@" responseClass=%@",NSStringFromClass(responseObject));
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"response=%@",operation.responseString);
        
        
    }];

}



///修改密码
- (void)changePasswordWithphone:(NSString *)phone loginNum:(NSString *)loginnum password:(NSString *)password
{
    YSHLoginVoModel *loginModel = [[YSHLoginVoModel alloc] init];
    loginModel.password = password;
    loginModel.phone = phone;
    loginModel.loginnum = loginnum;
    
    NSString *json = [loginModel toJSONString];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:RequestAPIBaseURL parameters:[[YSHPublicClass sharePublic] RequestParameters:ChangePasswordCode token:nil reportXML:json] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSLog(@" responseClass=%@",NSStringFromClass(responseObject));
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"response=%@",operation.responseString);
        
        
    }];

    
}


///修改 用户信息
- (void)changeUserInfoWithUserModel:(YSHAbUserModel *)userModel
{
    NSString *json = [userModel toJSONString];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:RequestAPIBaseURL parameters:[[YSHPublicClass sharePublic] RequestParameters:ChangeUserInfoCode token:nil reportXML:json] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSLog(@" responseClass=%@",NSStringFromClass(responseObject));
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"response=%@",operation.responseString);
        
        
    }];

}


/// 注销
- (void)loginOutWithUserModel:(YSHAbUserModel *)userModel
{
    NSString *json = [userModel toJSONString];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:RequestAPIBaseURL parameters:[[YSHPublicClass sharePublic] RequestParameters:LoginOutCode token:nil reportXML:json] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSLog(@" responseClass=%@",NSStringFromClass(responseObject));
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"response=%@",operation.responseString);
        
        
    }];

}

///获取栏目列表接口(1008)
- (void)categaryListWithUserModel:(YSHAbUserModel *)userModel
{
        NSString *json = [userModel toJSONString];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager POST:RequestAPIBaseURL parameters:[[YSHPublicClass sharePublic] RequestParameters:CategaryListCode token:nil reportXML:json] success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
            NSLog(@" responseClass=%@",NSStringFromClass(responseObject));
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"response=%@",operation.responseString);
            
            
        }];
        
}




////查询商户详情接口(1009)
- (void)businessInfoWithUserModel:(YSHAbUserModel *)userModel
{
    NSString *json = [userModel toJSONString];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:RequestAPIBaseURL parameters:[[YSHPublicClass sharePublic] RequestParameters:BusinessInfoCode token:nil reportXML:json] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSLog(@" responseClass=%@",NSStringFromClass(responseObject));
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"response=%@",operation.responseString);
        
        
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
        
        
    }];
    
}

///11.查询城市商圈接口(1011)
- (void)cityBusinessWithUserModel:(YSHAbUserModel *)userModel
{
    NSString *json = [userModel toJSONString];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:RequestAPIBaseURL parameters:[[YSHPublicClass sharePublic] RequestParameters:CityBusinessCode token:nil reportXML:json] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSLog(@" responseClass=%@",NSStringFromClass(responseObject));
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"response=%@",operation.responseString);
        
        
    }];
    
}

////12.模糊查询商户接口(1012)
- (void)WildcardQueryBusinessWithCityModel:(YSHCityVoModel *)cityModel
{
    NSString *json = [cityModel toJSONString];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:RequestAPIBaseURL parameters:[[YSHPublicClass sharePublic] RequestParameters:WildcardQueryBusinessCode token:nil reportXML:json] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSLog(@" responseClass=%@",NSStringFromClass(responseObject));
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"response=%@",operation.responseString);
        
        
    }];
    
}


///13.获取城市列表信息接口(1013)
- (void)cityListWithUserModel:(YSHAbUserModel *)userModel
{
    NSString *json = [userModel toJSONString];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:RequestAPIBaseURL parameters:[[YSHPublicClass sharePublic] RequestParameters:CityInfoCode token:nil reportXML:json] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSLog(@" responseClass=%@",NSStringFromClass(responseObject));
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"response=%@",operation.responseString);
        
        
    }];
    
}


@end
