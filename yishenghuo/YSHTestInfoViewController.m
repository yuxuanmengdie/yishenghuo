//
//  YSHTestInfoViewController.m
//  yishenghuo
//
//  Created by 张国俗 on 15-1-3.
//  Copyright (c) 2015年 雨轩梦蝶. All rights reserved.
//

#import "YSHTestInfoViewController.h"

@interface YSHTestInfoViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIView *sepView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sexSegment;

@property (weak, nonatomic) IBOutlet UIButton *startButton;

- (IBAction)startBtnAction:(id)sender;


@end

@implementation YSHTestInfoViewController

static NSString *const kBodyTestIdentifier = @"bodyTest";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _topView.backgroundColor = [UIColor whiteColor];
    _topView.layer.masksToBounds = YES;
    _topView.layer.cornerRadius = 10;
    _topView.layer.borderColor = KMainColor.CGColor;
    _topView.layer.borderWidth = 1.0;
    
    
    _nameLabel.textColor = KMainColor;
    _nameTextField.textColor = KMainColor;
    _nameTextField.text = nil;
    _nameTextField.placeholder = @"请输入";
    _nameTextField.delegate = self;
    [publicFuncClass addHiddenItemOnkeyboardWithView:_nameTextField delegate:self sel:@selector(hiddenKeyBoard)];
    _sepView.backgroundColor = KMainColor;
    _sexSegment.tintColor = KMainColor;

    [_startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_startButton setBackgroundImage:[publicFuncClass ImageWithColor:KMainColor] forState:UIControlStateNormal];
    [_startButton setContentEdgeInsets:UIEdgeInsetsMake(10, 0, 10, 0)];
    _startButton.layer.masksToBounds = YES;
    _startButton.layer.cornerRadius = 5;
    
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

- (void)hiddenKeyBoard
{
    [_nameTextField resignFirstResponder];
}


#pragma marl textField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_nameTextField resignFirstResponder];
    return YES;
}

#pragma mark 判断是否信息满足
- (BOOL)userInfoComplete
{
    if (self.nameTextField.text.length < 1) {
        return NO;
    }
    
    if (self.sexSegment.selectedSegmentIndex == UISegmentedControlNoSegment) {
        return NO;
    }
    
    return YES;
}
- (IBAction)startBtnAction:(id)sender {
    
    if (![self userInfoComplete]) {
        
        [Dialog toast:@"请完善信息"];
        return;
    }
    
    [self performSegueWithIdentifier:kBodyTestIdentifier sender:self];
}
@end
