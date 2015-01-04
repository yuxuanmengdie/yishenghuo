//
//  YSHSignUpViewController.m
//  yishenghuo
//
//  Created by 张国俗 on 14-11-11.
//  Copyright (c) 2014年 雨轩梦蝶. All rights reserved.
//

#import "YSHSignUpViewController.h"
#import "YSHAbUserModel.h"
#import "YSHSendCodeVoModel.h"



@interface YSHSignUpViewController ()<UITextFieldDelegate
>

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UIView *sepView1;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIView *sepView2;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UIButton *getCodeButton;
@property (weak, nonatomic) IBOutlet UIView *sepView3;

@property (weak, nonatomic) IBOutlet UIButton *singUpButton;

- (IBAction)signUpAction:(id)sender;

@end

@implementation YSHSignUpViewController

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
/// 获取验证码
- (IBAction)getCode:(id)sender {
    YSHSendCodeVoModel *send = [[YSHSendCodeVoModel alloc] init];
    send.phone = @"18559912772";
    send.type = @"01";
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

- (IBAction)signUpAction:(id)sender {
    
    
    
    
    YSHAbUserModel *model = [[YSHAbUserModel alloc] init];
//    model.loginnum = @"18559912772";
    model.loginnum = @"zhangguo";
    model.password = @"qwe123456";
    model.phone = @"18559912772";
    model.type = 1;
    model.verify_code = _codeTextField.text;
    model.verify_type = @"01";
    model.email = @"389655344@qq.com"; ///ok
    
    
    NSString *json = [model toJSONString];
    NSLog(@"%@",json);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:RequestAPIBaseURL parameters:[[YSHPublicClass sharePublic] RequestParameters:SighUpCode token:nil reportXML:json] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        //        NSLog(@" responseClass=%@",NSStringFromClass(responseObject));
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"response=%@",operation.responseString);
        
        
    }];
    
   
 //   [manager.operationQueue cancelAllOperations];
//    AFURLConnectionOperation *op =
    

    
    
    

    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
